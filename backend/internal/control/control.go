package control

import (
	"context"
	"database/sql"
	"fmt"
	engine "jingle_player_backend/internal/audio_engine"
	"jingle_player_backend/internal/db"
	pb "jingle_player_backend/internal/pb"
)

type AudioGRPCServer struct {
	pb.UnimplementedAudioServiceServer
	engine *engine.Player
	db     *db.Queries
}

func NewAudioGRPCServer(e *engine.Player, db *db.Queries) *AudioGRPCServer {
	return &AudioGRPCServer{engine: e, db: db}
}

func (s *AudioGRPCServer) PlaybackCommand(ctx context.Context, req *pb.PlaybackRequest) (*pb.PlaybackResponse, error) {
	if req.Action == "PLAY" {
		fmt.Println("Received play request:", req)
		err := s.engine.PlayAudio(0)
		if err != nil {
			return &pb.PlaybackResponse{Success: false, Message: err.Error()}, nil
		}
	}
	if req.Action == "STOP" {
		fmt.Println("Received stop request:", req)
		err := s.engine.StopAudio()
		if err != nil {
			return &pb.PlaybackResponse{Success: false, Message: err.Error()}, nil
		}
	}
	return &pb.PlaybackResponse{Success: true, Message: "Command accepted"}, nil
}

func (s *AudioGRPCServer) StreamPlaybackStatus(req *pb.AudioStatusRequest, stream pb.AudioService_StreamPlaybackStatusServer) error {
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
				fmt.Println("gRPC: Error sending data to client: ", err)
				return err
			}

		}
	}
}

func (s *AudioGRPCServer) ListPalettes(ctx context.Context, req *pb.PaletteListRequest) (*pb.PaletteListResponse, error) {
	palettes, err := s.db.ListPalettes(ctx)
	if err != nil {
		return &pb.PaletteListResponse{Success: false}, nil
	}
	res := MapDBPalettesToPB(palettes)

	return &pb.PaletteListResponse{Success: true, Palettes: res}, nil
}

func (s *AudioGRPCServer) GetPalette(ctx context.Context, req *pb.PaletteID) (*pb.PaletteGetResponse, error) {
	palette, err := s.db.GetPalette(ctx, int64(req.Id))
	if err != nil {
		return &pb.PaletteGetResponse{Success: false}, nil
	}
	res := MapDBPaletteToPB(palette)
	return &pb.PaletteGetResponse{Success: true, Palette: res}, nil
}

func (s *AudioGRPCServer) CreatePalette(ctx context.Context, req *pb.Palette) (*pb.Palette, error) {
	_, err := s.db.CreatePalette(ctx, db.CreatePaletteParams{Name: req.Name,
		Slot0File:  Int32ToSqlNullInt64(req.Slots[0].File.Id),
		Slot1File:  Int32ToSqlNullInt64(req.Slots[1].File.Id),
		Slot2File:  Int32ToSqlNullInt64(req.Slots[2].File.Id),
		Slot3File:  Int32ToSqlNullInt64(req.Slots[3].File.Id),
		Slot4File:  Int32ToSqlNullInt64(req.Slots[4].File.Id),
		Slot5File:  Int32ToSqlNullInt64(req.Slots[5].File.Id),
		Slot6File:  Int32ToSqlNullInt64(req.Slots[6].File.Id),
		Slot7File:  Int32ToSqlNullInt64(req.Slots[7].File.Id),
		Slot8File:  Int32ToSqlNullInt64(req.Slots[8].File.Id),
		Slot9File:  Int32ToSqlNullInt64(req.Slots[9].File.Id),
		Slot10File: Int32ToSqlNullInt64(req.Slots[10].File.Id),
		Slot11File: Int32ToSqlNullInt64(req.Slots[11].File.Id),
		Slot12File: Int32ToSqlNullInt64(req.Slots[12].File.Id),
		Slot13File: Int32ToSqlNullInt64(req.Slots[13].File.Id),
		Slot14File: Int32ToSqlNullInt64(req.Slots[14].File.Id),
		Slot15File: Int32ToSqlNullInt64(req.Slots[15].File.Id),
	})
	if err != nil {
		return &pb.Palette{}, err
	}
	return req, nil
}

func (s *AudioGRPCServer) UpdatePalette(ctx context.Context, req *pb.Palette) (*pb.Palette, error) {
	err := s.db.UpdatePalette(ctx, db.UpdatePaletteParams{
		ID:         int64(req.Id),
		Name:       req.Name,
		Slot0File:  Int32ToSqlNullInt64(req.Slots[0].File.Id),
		Slot1File:  Int32ToSqlNullInt64(req.Slots[1].File.Id),
		Slot2File:  Int32ToSqlNullInt64(req.Slots[2].File.Id),
		Slot3File:  Int32ToSqlNullInt64(req.Slots[3].File.Id),
		Slot4File:  Int32ToSqlNullInt64(req.Slots[4].File.Id),
		Slot5File:  Int32ToSqlNullInt64(req.Slots[5].File.Id),
		Slot6File:  Int32ToSqlNullInt64(req.Slots[6].File.Id),
		Slot7File:  Int32ToSqlNullInt64(req.Slots[7].File.Id),
		Slot8File:  Int32ToSqlNullInt64(req.Slots[8].File.Id),
		Slot9File:  Int32ToSqlNullInt64(req.Slots[9].File.Id),
		Slot10File: Int32ToSqlNullInt64(req.Slots[10].File.Id),
		Slot11File: Int32ToSqlNullInt64(req.Slots[11].File.Id),
		Slot12File: Int32ToSqlNullInt64(req.Slots[12].File.Id),
		Slot13File: Int32ToSqlNullInt64(req.Slots[13].File.Id),
		Slot14File: Int32ToSqlNullInt64(req.Slots[14].File.Id),
		Slot15File: Int32ToSqlNullInt64(req.Slots[15].File.Id),
	})
	if err != nil {
		return &pb.Palette{}, err
	}
	return req, nil
}

func (s *AudioGRPCServer) DeletePalette(ctx context.Context, req *pb.PaletteID) (*pb.PaletteDeleteResponse, error) {
	err := s.db.DeletePalette(ctx, int64(req.Id))
	if err != nil {
		return &pb.PaletteDeleteResponse{Success: false}, err
	}
	return &pb.PaletteDeleteResponse{Success: true}, nil
}

func (s *AudioGRPCServer) CreateAudioFile(ctx context.Context, req *pb.AudioFile) (*pb.AudioFile, error) {
	_, err := s.db.CreateAudioFile(ctx, db.CreateAudioFileParams{
		Name: req.FileName,
		Path: req.FilePath,
	})
	if err != nil {
		return &pb.AudioFile{}, err
	}
	return req, nil
}

func (s *AudioGRPCServer) UpdateAudioFile(ctx context.Context, req *pb.AudioFile) (*pb.AudioFile, error) {
	err := s.db.UpdateAudioFile(ctx, db.UpdateAudioFileParams{
		ID:   int64(req.Id),
		Name: req.FileName,
		Path: req.FilePath,
	})
	if err != nil {
		return &pb.AudioFile{}, err
	}
	return req, nil
}

func (s *AudioGRPCServer) DeleteAudioFile(ctx context.Context, req *pb.AudioFileID) (*pb.AudioFileDeleteResponse, error) {
	err := s.db.DeleteAudioFile(ctx, int64(req.Id))
	if err != nil {
		return &pb.AudioFileDeleteResponse{Success: false}, err
	}
	return &pb.AudioFileDeleteResponse{Success: true}, nil
}

func (s *AudioGRPCServer) GetAudioFile(ctx context.Context, req *pb.AudioFileID) (*pb.GetAudioFileResponse, error) {
	file, err := s.db.GetAudioFile(ctx, int64(req.Id))

	res := mapDBToAudioFile(Int64ToSqlNullInt64(file.ID), sql.NullString{Valid: true, String: file.Path}, sql.NullString{Valid: true, String: file.Name})
	if err != nil {
		return &pb.GetAudioFileResponse{Success: false}, err
	}
	return &pb.GetAudioFileResponse{Success: true, AudioFile: res}, nil
}

func (s *AudioGRPCServer) ListAudioFiles(ctx context.Context, req *pb.ListAudioFileRequest) (*pb.AudioFileList, error) {
	list, err := s.db.ListAudioFiles(ctx)
	res := MapDBAudioFilesToPB(list)
	if err != nil {
		return &pb.AudioFileList{}, err
	}

	return &pb.AudioFileList{AudioFiles: res}, nil
}

func (s *AudioGRPCServer) AssignAudioFileToSlot(ctx context.Context, req *pb.AssignAudioFileRequest) (*pb.PlayerSlot, error) {
	file, err := s.db.GetAudioFile(ctx, int64(req.FileId))
	if err != nil {
		return nil, err
	}

	s.engine.Slots[req.SlotId] = &engine.PlayerSlot{AudioFile: engine.AudioFile{ID: int32(file.ID), FileName: file.Name, FilePath: file.Path}}
	return &pb.PlayerSlot{Id: req.SlotId, File: &pb.AudioFile{Id: int32(file.ID), FileName: file.Name, FilePath: file.Path}}, nil
}

func (s *AudioGRPCServer) UnassignAudioFileFromSlot(ctx context.Context, req *pb.UnassignAudioFileRequest) (*pb.PlayerSlot, error) {
	s.engine.Slots[req.SlotId] = &engine.PlayerSlot{AudioFile: engine.AudioFile{}}
	return &pb.PlayerSlot{Id: req.SlotId, File: &pb.AudioFile{}}, nil
}
