package audio_engine

import (
	"context"
	"fmt"
	"io"
	"jingle_player_backend/internal/db"
	"os"
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
	AudioStatus
	listeners      map[chan AudioStatus]struct{}
	mu             sync.RWMutex
	Slots          map[int32]*PlayerSlot
	cancelPlayback context.CancelFunc
}

type PlayerSlot struct {
	ID        int32
	AudioFile db.AudioFile
}

// type AudioFile struct {
// 	ID       int32
// 	FileName string
// 	FilePath string
// 	Duration time.Duration
// }

type PlaybackState string

const (
	StatePlaying PlaybackState = "PLAYING"
	StateStopped PlaybackState = "STOPPED"
)

type AudioStatus struct {
	ActiveSlot    int
	State         PlaybackState
	TimeRemaining float64
}

func InitPlayer(sampleRate int, bufferSize int) (*Player, error) {
	var numSlots = 16

	err := portaudio.Initialize()
	if err != nil {
		return nil, err
	}
	p := &Player{init: true, sampleRate: uint32(sampleRate), channels: 2, bitDepth: 16, bufferSize: bufferSize,
		AudioStatus: AudioStatus{ActiveSlot: 0, State: StateStopped, TimeRemaining: 0},
		listeners:   make(map[chan AudioStatus]struct{}), Slots: make(map[int32]*PlayerSlot)}

	for i := 0; i <= numSlots-1; i++ {
		id := int32(i)
		p.Slots[id] = &PlayerSlot{ID: id}
	}

	go p.broadcastPlayerState()
	return p, nil
}

// allow clients to read audio state
func (p *Player) SubscribeToPlayerState() (chan AudioStatus, func()) {

	p.mu.Lock()
	ch := make(chan AudioStatus, 10)
	p.listeners[ch] = struct{}{}
	p.mu.Unlock()

	fmt.Println("New client subscribed to gRPC channel")
	ch <- p.AudioStatus

	unsub := func() {
		p.mu.Lock()
		delete(p.listeners, ch)
		p.mu.Unlock()
	}
	return ch, unsub
}

// send audiostatus to subscribed clients
func (p *Player) broadcastPlayerState() {
	fmt.Println("Started broadcasting player state")
	ticker := time.NewTicker(100 * time.Millisecond)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			p.mu.RLock()
			currentState := AudioStatus{State: p.State, ActiveSlot: p.ActiveSlot, TimeRemaining: p.TimeRemaining}
			p.mu.RUnlock()
			for ch := range p.listeners {
				select {
				case ch <- currentState:
				default:
				}
			}
		}
	}
}

func (p *Player) Close() error {
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
	p.mu.Lock()
	cancel := p.cancelPlayback
	p.cancelPlayback = nil
	p.mu.Unlock()
	fmt.Println("Stopping playback")
	cancel()
	return nil
}

func (p *Player) PlayAudio(slotID int32) error {
	ctx, cancel := context.WithCancel(context.Background())
	p.mu.Lock()
	p.cancelPlayback = cancel
	p.mu.Unlock()
	go p.runAudioPlayback(ctx, slotID)
	return nil
}

func (p *Player) runAudioPlayback(ctx context.Context, slotID int32) error {
	slot := *p.Slots[slotID]
	f, err := os.Open(slot.AudioFile.Path)
	if err != nil {
		fmt.Printf("Failed to load file from disk:", err)
		return err
	}
	defer func() {
		p.mu.Lock()
		p.cancelPlayback = nil
		p.AudioStatus = AudioStatus{State: StateStopped}
		p.mu.Unlock()
		f.Close()
	}()

	decoder := wav.NewDecoder(f)
	if !decoder.IsValidFile() {
		fmt.Printf("Invalid wav")
		return err
	}

	sampleRate := decoder.SampleRate
	channels := int(decoder.Format().NumChannels)
	bitDepth := int(decoder.BitDepth)
	duration := decoder.Duration

	fmt.Printf("Playing: %d-bit WAV, %dHz, %d channels, %d duration\n", bitDepth, sampleRate, channels, duration)

	audioOutBuffer := make([]int16, p.bufferSize)
	stream, err := portaudio.OpenDefaultStream(0, p.channels, float64(p.sampleRate), len(audioOutBuffer), &audioOutBuffer)
	if err != nil {
		return err
	}
	stream.Start()
	p.AudioStatus = AudioStatus{ActiveSlot: int(slotID), State: StatePlaying, TimeRemaining: 0}
	defer stream.Close()

	goAudioBuffer := &audio.IntBuffer{
		Data:   make([]int, p.bufferSize),
		Format: decoder.Format(),
	}
	go func() {
		<-ctx.Done()
		p.AudioStatus = AudioStatus{ActiveSlot: int(slotID), State: StateStopped, TimeRemaining: 0}
		fmt.Println("Playback stopped.")
		stream.Abort()
	}()
	for {
		n, err := decoder.PCMBuffer(goAudioBuffer)
		if err != nil && err != io.EOF {
			fmt.Printf("Error decoding audio: %v\n", err)
			break
		}
		if n == 0 {

			p.AudioStatus = AudioStatus{ActiveSlot: int(slotID), State: StateStopped, TimeRemaining: 0}
			fmt.Println("Playback stopped (EOF)")
			break // End of file
		}

		for i := 0; i < n; i++ {
			audioOutBuffer[i] = int16(goAudioBuffer.Data[i])
		}

		if n < len(audioOutBuffer) {
			for i := n; i < len(audioOutBuffer); i++ {
				audioOutBuffer[i] = 0
			}
		}

		err = stream.Write()
		if err != nil {
			fmt.Printf("Error writing to audio stream: %v\n", err)
			break
		}
	}
	return nil
}
