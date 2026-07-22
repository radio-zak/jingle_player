package control

import (
	"context"
	"fmt"
	engine "jingle_player_backend/internal/audio_engine"
	pb "jingle_player_backend/internal/pb"
)

type AudioGRPCServer struct {
	pb.UnimplementedAudioServiceServer
	engine *engine.Player
}

func NewAudioGRPCServer(e *engine.Player) *AudioGRPCServer {
	return &AudioGRPCServer{engine: e}
}

func (s *AudioGRPCServer) TriggerCommand(ctx context.Context, req *pb.CommandRequest) (*pb.ActionResponse, error) {
	if req.Action == "PLAY" {
		fmt.Println("Received request:", req)
		err := s.engine.PlayAudio(0)
		if err != nil {
			return &pb.ActionResponse{Success: false, Message: err.Error()}, nil
		}
	}
	if req.Action == "STOP" {
		fmt.Println("Received stop request:", req)
		err := s.engine.StopAudio()
		if err != nil {
			return &pb.ActionResponse{Success: false, Message: err.Error()}, nil
		}
	}
	return &pb.ActionResponse{Success: true, Message: "Command accepted"}, nil
}

func (s *AudioGRPCServer) StreamPlaybackStatus(req *pb.StatusRequest, stream pb.AudioService_StreamPlaybackStatusServer) error {
	ch, unsub := s.engine.SubscribeToPlayerState()
	defer unsub()

	for {
		select {
		case <-stream.Context().Done():
			fmt.Println("gRPC: Client disconnected from playback status stream")
			return stream.Context().Err()
		case data, ok := <-ch:
			if !ok {
				return nil
			}
			audioStatus := &pb.AudioStatus{
				ActiveSlot:           int32(data.ActiveSlot),
				State:                string(data.State),
				TimeRemainingSeconds: data.TimeRemaining,
			}
			err := stream.Send(audioStatus)
			if err != nil {
				fmt.Println("gRPC: Error sending data to client")
				return err
			}

		}
	}
}
