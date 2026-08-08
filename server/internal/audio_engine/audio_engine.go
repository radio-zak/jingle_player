package audio_engine

import (
	"context"
	"djinn_server/internal/config"
	"djinn_server/internal/models"
	"djinn_server/internal/uiservice"
	"fmt"
	"io"
	"os"
	"path"
	"sync"
	"time"

	"github.com/go-audio/audio"
	"github.com/go-audio/wav"
	"github.com/gordonklaus/portaudio"
)

type Player struct {
	init       bool
	sampleRate uint32
	channels   int
	bitDepth   int
	bufferSize int
	config     *config.Config
	*models.AudioStatus
	UI             *uiservice.UIService
	Mu             sync.RWMutex
	Slots          [16]*models.PlayerSlot
	cancelPlayback context.CancelFunc
}

func InitPlayer(cfg *config.Config) (*Player, error) {
	var numSlots = 16

	err := portaudio.Initialize()
	if err != nil {
		return nil, err
	}
	p := &Player{init: true, sampleRate: uint32(cfg.Audio.SampleRate), channels: 2, bitDepth: 24, bufferSize: cfg.Audio.BufferSize,
		AudioStatus: &models.AudioStatus{ActiveSlot: nil, State: models.StateStopped, TimeRemaining: 0},
		UI:          uiservice.NewUIService()}

	for i := 0; i <= numSlots-1; i++ {
		id := int32(i)
		p.Slots[id] = &models.PlayerSlot{ID: id}
	}

	go p.broadcastPlayerState()
	go p.broadcastSlotState()
	return p, nil
}

// send audiostatus to subscribed clients
func (p *Player) broadcastPlayerState() {
	fmt.Println("Started broadcasting player state")
	ticker := time.NewTicker(100 * time.Millisecond)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			p.Mu.RLock()
			p.UI.Mu.RLock()
			currentAudioState := p.AudioStatus
			p.Mu.RUnlock()
			p.UI.Mu.RUnlock()
			// if p.UI.LastAudioStatus == currentAudioState {
			// 	continue
			// }
			p.UI.Mu.Lock()
			p.UI.LastAudioStatus = currentAudioState
			p.UI.Mu.Unlock()
			for ch := range p.UI.StatusListeners {
				select {
				case ch <- *currentAudioState:
				default:
				}
			}
		}
	}
}
func (p *Player) broadcastSlotState() {
	fmt.Println("Started broadcasting slot state")
	ticker := time.NewTicker(500 * time.Millisecond)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			for i := 0; i < 16; i++ {
				p.Mu.RLock()
				p.UI.Mu.RLock()
				slot := p.Slots[int32(i)]
				p.Mu.RUnlock()
				p.UI.Mu.RUnlock()
				if p.UI.LastSlotState[i] == slot {
					continue
				}
				p.UI.Mu.Lock()
				p.UI.LastSlotState[i] = slot
				p.UI.Mu.Unlock()
				for ch := range p.UI.SlotListeners {
					select {
					case ch <- *slot:
					default:
					}
				}
			}
		}
	}
}

func (p *Player) Close() error {
	fmt.Println("Shutting down PortAudio")
	if !p.init {
		return nil
	}
	return portaudio.Terminate()
}

func (p *Player) GetVersion() string {
	v := portaudio.VersionText()
	return v
}

func (p *Player) EnumDevices() ([]*portaudio.DeviceInfo, error) {
	dev, err := portaudio.Devices()
	if err != nil {
		return nil, err
	}
	return dev, nil
}

func (p *Player) StopAudio() error {
	p.Mu.Lock()
	cancel := p.cancelPlayback
	p.Mu.Unlock()
	if cancel != nil {
		fmt.Println("Stopping playback...")
		cancel()
		p.Mu.Lock()
		p.cancelPlayback = nil
		p.Mu.Unlock()
		p.updateAudioStatus(nil, models.StateStopped, 0)

	} else {
		fmt.Println("Attempted stop operation on already stopped audio")
		p.updateAudioStatus(nil, models.StateStopped, 0)
	}
	return nil
}

func (p *Player) PlayAudio() error {
	ctx, cancel := context.WithCancel(context.Background())
	p.Mu.Lock()
	p.cancelPlayback = cancel
	p.Mu.Unlock()
	if p.ActiveSlot != nil {
		fmt.Println("playing audio from slot", *p.ActiveSlot)
		go p.runAudioPlayback(ctx, *p.ActiveSlot)
	} else {
		fmt.Println("No slot active - no playback")
	}
	return nil
}

func (p *Player) runAudioPlayback(ctx context.Context, slotID int32) error {
	slot := p.Slots[slotID].GetFileName()
	path := path.Join("./media", slot)
	fmt.Printf("Opening file %v", path)
	f, err := os.Open(path)
	if err != nil {
		fmt.Printf("Failed to load file from disk:", err)
		return err
	}
	defer func() {
		p.Mu.Lock()
		p.updateAudioStatus(nil, models.StateStopped, 0)
		f.Close()
	}()

	decoder := wav.NewDecoder(f)
	if !decoder.IsValidFile() {
		fmt.Printf("Invalid wav")
		return err
	}
	fmt.Println("Setting decoder configuration")
	sampleRate := decoder.SampleRate
	channels := int(decoder.Format().NumChannels)
	bitDepth := int(decoder.BitDepth)
	duration := decoder.Duration
	maxVal := float32(int(1) << (bitDepth - 1))

	fmt.Printf("Playing: %d-bit WAV, %dHz, %d channels, %d duration\n", bitDepth, sampleRate, channels, duration)

	audioOutBuffer := make([]float32, p.bufferSize)
	stream, err := portaudio.OpenDefaultStream(0, channels, float64(sampleRate), len(audioOutBuffer), &audioOutBuffer)
	if err != nil {
		return err
	}
	stream.Start()
	p.updateAudioStatus(&slotID, models.StatePlaying, 0)
	defer stream.Close()

	goAudioBuffer := &audio.IntBuffer{
		Data:   make([]int, p.bufferSize),
		Format: decoder.Format(),
	}
	go func() {
		<-ctx.Done()
		fmt.Println("Stopping playback...")
		stream.Stop()
	}()
	for {
		select {
		case <-ctx.Done():
			p.updateAudioStatus(nil, models.StateStopped, 0)
			fmt.Println("Stopped playback")
			return ctx.Err()
		default:
			n, err := decoder.PCMBuffer(goAudioBuffer)
			if err != nil && err != io.EOF {
				fmt.Printf("Error decoding audio: %v\n", err)
				break
			}
			if n == 0 {
				p.updateAudioStatus(nil, models.StateStopped, 0)
				fmt.Println("Playback stopped (EOF)")
				break // End of file
			}

			for i := 0; i < n; i++ {
				for i, val := range goAudioBuffer.Data {
					audioOutBuffer[i] = float32(val) / maxVal // Scale into [-1.0, 1.0] range
				}
			}

			if n < len(audioOutBuffer) {
				for i := n; i < len(audioOutBuffer); i++ {
					audioOutBuffer[i] = 0
					break
				}
			}

			err = stream.Write()
			if err != nil {
				fmt.Printf("Error writing to audio stream: %v\n", err)
				break
			}
		}
	}
}

func (p *Player) updateAudioStatus(slotID *int32, state models.PlaybackState, timeRemaining float64) {
	p.Mu.Lock()
	p.AudioStatus = &models.AudioStatus{ActiveSlot: slotID, State: state, TimeRemaining: timeRemaining}
	p.Mu.Unlock()
}
