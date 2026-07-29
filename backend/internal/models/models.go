package models

import "jingle_player_backend/internal/db"

type PlayerSlot struct {
	ID        int32
	AudioFile db.AudioFile
}

type AudioStatus struct {
	ActiveSlot    int
	State         PlaybackState
	TimeRemaining float64
}

type PlaybackState string

const (
	StatePlaying PlaybackState = "PLAYING"
	StateStopped PlaybackState = "STOPPED"
)
