package uiservice

import (
	"fmt"
	"jingle_player_backend/internal/models"
	"sync"
)

type UIService struct {
	Mu              sync.RWMutex
	StatusListeners map[chan models.AudioStatus]struct{}
	SlotListeners   map[chan models.PlayerSlot]struct{}
	LastAudioStatus *models.AudioStatus
	LastSlotState   []*models.PlayerSlot
}

func NewUIService() *UIService {
	return &UIService{
		Mu:              sync.RWMutex{},
		StatusListeners: make(map[chan models.AudioStatus]struct{}),
		SlotListeners:   make(map[chan models.PlayerSlot]struct{}),
		LastSlotState:   make([]*models.PlayerSlot, 16),
	}
}

// allow clients to read audio state
func (u *UIService) SubscribeToPlayerState() (chan models.AudioStatus, func()) {
	u.Mu.Lock()
	ch := make(chan models.AudioStatus, 30)
	u.StatusListeners[ch] = struct{}{}
	u.Mu.Unlock()

	fmt.Println("New client subscribed to gRPC channel")
	u.Mu.RLock()
	status := u.LastAudioStatus
	u.Mu.RUnlock()
	if status != nil {
		ch <- *u.LastAudioStatus
	}

	unsub := func() {
		u.Mu.Lock()
		delete(u.StatusListeners, ch)
		u.Mu.Unlock()
	}
	return ch, unsub
}

// allow clients to read audio state
func (u *UIService) SubscribeToSlotState() (chan models.PlayerSlot, func()) {
	u.Mu.Lock()
	ch := make(chan models.PlayerSlot, 32)
	u.SlotListeners[ch] = struct{}{}
	u.Mu.Unlock()

	fmt.Println("New client subscribed to UI gRPC channel")
	for i := 0; i < 16; i++ {
		u.Mu.Lock()
		slot := u.LastSlotState[i]
		u.Mu.Unlock()
		if slot != nil {
			ch <- *slot
		}
	}

	unsub := func() {
		u.Mu.Lock()
		delete(u.SlotListeners, ch)
		u.Mu.Unlock()
	}
	return ch, unsub
}
