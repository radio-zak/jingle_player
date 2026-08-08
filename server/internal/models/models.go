package models

import "djinn_server/internal/db"

type PlayerSlot struct {
	ID        int32
	AudioFile *db.AudioFile
}

type AudioStatus struct {
	ActiveSlot    *int32
	State         PlaybackState
	TimeRemaining float64
}

type PlaybackState string

const (
	StatePlaying PlaybackState = "PLAYING"
	StateStopped PlaybackState = "STOPPED"
)

func (s *PlayerSlot) GetFileName() string {
	if s == nil || s.AudioFile == nil {
		return "" // Or "Empty Slot"
	}
	return s.AudioFile.Name
}

func (s *PlayerSlot) HasAudio() bool {
	return s != nil && s.AudioFile != nil
}
