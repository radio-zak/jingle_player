package control

import (
	"context"
	"database/sql"
	"fmt"
	"io"
	engine "jingle_player_backend/internal/audio_engine"
	"jingle_player_backend/internal/db"
	"jingle_player_backend/internal/models"
	pb "jingle_player_backend/internal/pb"
	"os"
	"path"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
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
		err := s.engine.PlayAudio()
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
	ch, unsub := s.engine.UI.SubscribeToPlayerState()
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

func (s *AudioGRPCServer) StreamSlotStatus(req *pb.SlotStatusRequest, stream pb.AudioService_StreamSlotStatusServer) error {
	ch, unsub := s.engine.UI.SubscribeToSlotState()
	defer unsub()

	for {
		select {
		case <-stream.Context().Done():
			fmt.Println("gRPC: Client disconnected from slot status stream")
			return stream.Context().Err()
		case data, ok := <-ch:
			if !ok {
				return nil
			}
			slotStatus := &pb.PlayerSlot{
				Id:   int32(data.ID),
				File: &pb.AudioFile{Id: int32(data.AudioFile.ID), FileName: data.AudioFile.Name, FilePath: data.AudioFile.Path},
			}
			err := stream.Send(slotStatus)
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

func (s *AudioGRPCServer) CreatePalette(ctx context.Context, req *pb.Palette) (*pb.PaletteResponse, error) {
	exists, err := s.db.PaletteNameExists(ctx, req.Name)
	if err != nil {
		fmt.Println("Error reading palettes from database", err)
		return &pb.PaletteResponse{Success: false, Message: "Error reading palettes from database"}, err
	}

	if exists == 1 {
		fmt.Println("Palette with this name exists in database", err)
		return &pb.PaletteResponse{Success: false, Message: "Palette with this name exists in database"}, err
	}

	if _, err := s.db.CreatePalette(ctx, db.CreatePaletteParams{Name: req.Name,
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
	}); err != nil {
		return &pb.PaletteResponse{Success: false, Message: "Failed to create palette."}, err
	}
	return &pb.PaletteResponse{Success: true, Message: "Palette created"}, nil
}

func (s *AudioGRPCServer) UpdatePalette(ctx context.Context, req *pb.Palette) (*pb.PaletteResponse, error) {
	exists, err := s.db.PaletteNameExists(ctx, req.Name)
	if err != nil {
		fmt.Println("Error reading palettes from database", err)
		return &pb.PaletteResponse{Success: false, Message: "Error reading palettes from database"}, err
	}

	if exists == 1 {
		fmt.Println("Palette with this name exists in database", err)
		return &pb.PaletteResponse{Success: false, Message: "Palette with this name exists in database"}, err
	}
	err = s.db.UpdatePalette(ctx, db.UpdatePaletteParams{
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
		return &pb.PaletteResponse{Success: false, Message: "Failed to update palette"}, err
	}
	return &pb.PaletteResponse{Success: true, Message: "Palette updated"}, nil
}

func (s *AudioGRPCServer) DeletePalette(ctx context.Context, req *pb.PaletteID) (*pb.PaletteDeleteResponse, error) {
	err := s.db.DeletePalette(ctx, int64(req.Id))
	if err != nil {
		return &pb.PaletteDeleteResponse{Success: false}, err
	}
	return &pb.PaletteDeleteResponse{Success: true}, nil
}

func (s *AudioGRPCServer) CreateAudioFile(stream pb.AudioService_CreateAudioFileServer) error {
	req, err := stream.Recv()
	ctx := stream.Context()
	if err != nil {
		fmt.Println("Failed to get metadata from client", err)
		return status.Errorf(codes.FailedPrecondition, "Failed to get metadata from client")
	}

	meta := req.GetMetadata()
	if meta == nil {
		fmt.Println("Failed to get metadata from client", err)
		return status.Errorf(codes.FailedPrecondition, "Failed to get metadata from client")
	}

	namechk, err := s.db.AudioFileNameExists(ctx, meta.FileName)
	if err != nil {
		fmt.Println("Error retrieving from database", err)
		return status.Errorf(codes.Internal, "Error retrieving from DB")
	}
	if namechk == 1 {
		fmt.Println("A file with this name already exists", err)
		return status.Errorf(codes.InvalidArgument, "File with this name already exists")
	}

	pathchk, err := s.db.AudioFilePathExists(ctx, meta.FilePath)
	if err != nil {
		fmt.Println("Error retrieving from database", err)
		return status.Errorf(codes.Internal, "Error retrieving from DB")
	}
	if pathchk == 1 {
		fmt.Println("A file with this path already exists", err)
		return status.Errorf(codes.InvalidArgument, "File with this path already exists")
	}

	var fileBytes []byte
	var fileSize int64 = 0

	for {
		req, err := stream.Recv()
		if err == io.EOF {
			break
		}
		chunks := req.GetChunks()
		fileBytes = append(fileBytes, chunks...)
		fileSize += int64(len(chunks))
	}

	fp := path.Join("./media", meta.FileName)
	f, err := os.Create(fp)
	if err != nil {
		fmt.Println("Error creating file in media directory:", err)
		return status.Errorf(codes.Internal, "Error creating file in media directory: ", err)
	}
	defer f.Close()

	_, err = f.Write(fileBytes)
	if err != nil {
		fmt.Println("Error writing file to media directory:", err)
		return status.Errorf(codes.Internal, "Error writing file to media directory: ", err)
	}

	if _, err := s.db.CreateAudioFile(ctx, db.CreateAudioFileParams{
		Name: meta.FileName,
		Path: meta.FilePath,
	}); err != nil {
		fmt.Println("Error creating audio file", err)
		return status.Errorf(codes.Internal, "Error creating audio file in DB: ", err)
	}
	return stream.SendAndClose(&pb.AudioFileResponse{Success: true, Message: "File created in database"})
}

func (s *AudioGRPCServer) UpdateAudioFile(ctx context.Context, req *pb.AudioFile) (*pb.AudioFileResponse, error) {
	file, err := s.db.GetAudioFile(ctx, int64(req.Id))
	if err != nil {
		return &pb.AudioFileResponse{Success: false, Message: "Failed getting audio file in DB"}, err
	}
	fp1 := path.Join("./media", file.Name)
	fp2 := path.Join("./media", req.FileName)
	err = os.Rename(fp1, fp2)
	if err != nil {
		return &pb.AudioFileResponse{Success: false, Message: "Unable to update audio file path on disk"}, err
	}
	err = s.db.UpdateAudioFile(ctx, db.UpdateAudioFileParams{
		ID:   int64(req.Id),
		Name: req.FileName,
		Path: req.FilePath,
	})
	if err != nil {
		return &pb.AudioFileResponse{Success: false, Message: "Unable to update audio file"}, err
	}
	return &pb.AudioFileResponse{Success: true, Message: "Updated audio file"}, nil
}

func (s *AudioGRPCServer) DeleteAudioFile(ctx context.Context, req *pb.AudioFileID) (*pb.AudioFileDeleteResponse, error) {
	file, err := s.db.GetAudioFile(ctx, int64(req.Id))
	if err != nil {
		return &pb.AudioFileDeleteResponse{Success: false}, err
	}
	fp := path.Join("./media", file.Name)
	err = os.Remove(fp)
	if err != nil {
		return &pb.AudioFileDeleteResponse{Success: false}, err
	}
	err = s.db.DeleteAudioFile(ctx, int64(req.Id))
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

	s.engine.Slots[req.SlotId] = &models.PlayerSlot{AudioFile: db.AudioFile{ID: file.ID, Name: file.Name, Path: file.Path}}
	return &pb.PlayerSlot{Id: req.SlotId, File: &pb.AudioFile{Id: int32(file.ID), FileName: file.Name, FilePath: file.Path}}, nil
}

func (s *AudioGRPCServer) UnassignAudioFileFromSlot(ctx context.Context, req *pb.UnassignAudioFileRequest) (*pb.PlayerSlot, error) {
	s.engine.Slots[req.SlotId] = &models.PlayerSlot{AudioFile: db.AudioFile{}}
	return &pb.PlayerSlot{Id: req.SlotId, File: &pb.AudioFile{}}, nil
}

func (s *AudioGRPCServer) ActivatePalette(ctx context.Context, req *pb.PaletteID) (*pb.PaletteActivateResponse, error) {
	join, err := s.db.GetPaletteWithAudioFiles(ctx, int64(req.Id))
	if err != nil {
		return &pb.PaletteActivateResponse{Success: false}, err
	}
	s.engine.Slots[0] = &models.PlayerSlot{ID: 0, AudioFile: db.AudioFile{ID: join.Slot0ID.Int64, Name: join.Slot0Name.String, Path: join.Slot0Path.String}}
	s.engine.Slots[1] = &models.PlayerSlot{ID: 1, AudioFile: db.AudioFile{ID: join.Slot1ID.Int64, Name: join.Slot1Name.String, Path: join.Slot1Path.String}}
	s.engine.Slots[2] = &models.PlayerSlot{ID: 2, AudioFile: db.AudioFile{ID: join.Slot2ID.Int64, Name: join.Slot2Name.String, Path: join.Slot2Path.String}}
	s.engine.Slots[3] = &models.PlayerSlot{ID: 3, AudioFile: db.AudioFile{ID: join.Slot3ID.Int64, Name: join.Slot3Name.String, Path: join.Slot3Path.String}}
	s.engine.Slots[4] = &models.PlayerSlot{ID: 4, AudioFile: db.AudioFile{ID: join.Slot4ID.Int64, Name: join.Slot4Name.String, Path: join.Slot4Path.String}}
	s.engine.Slots[5] = &models.PlayerSlot{ID: 5, AudioFile: db.AudioFile{ID: join.Slot5ID.Int64, Name: join.Slot5Name.String, Path: join.Slot5Path.String}}
	s.engine.Slots[6] = &models.PlayerSlot{ID: 6, AudioFile: db.AudioFile{ID: join.Slot6ID.Int64, Name: join.Slot6Name.String, Path: join.Slot6Path.String}}
	s.engine.Slots[7] = &models.PlayerSlot{ID: 7, AudioFile: db.AudioFile{ID: join.Slot7ID.Int64, Name: join.Slot7Name.String, Path: join.Slot7Path.String}}
	s.engine.Slots[8] = &models.PlayerSlot{ID: 8, AudioFile: db.AudioFile{ID: join.Slot8ID.Int64, Name: join.Slot8Name.String, Path: join.Slot8Path.String}}
	s.engine.Slots[9] = &models.PlayerSlot{ID: 9, AudioFile: db.AudioFile{ID: join.Slot9ID.Int64, Name: join.Slot9Name.String, Path: join.Slot9Path.String}}
	s.engine.Slots[10] = &models.PlayerSlot{ID: 10, AudioFile: db.AudioFile{ID: join.Slot10ID.Int64, Name: join.Slot10Name.String, Path: join.Slot10Path.String}}
	s.engine.Slots[11] = &models.PlayerSlot{ID: 11, AudioFile: db.AudioFile{ID: join.Slot11ID.Int64, Name: join.Slot11Name.String, Path: join.Slot11Path.String}}
	s.engine.Slots[12] = &models.PlayerSlot{ID: 12, AudioFile: db.AudioFile{ID: join.Slot12ID.Int64, Name: join.Slot12Name.String, Path: join.Slot12Path.String}}
	s.engine.Slots[13] = &models.PlayerSlot{ID: 13, AudioFile: db.AudioFile{ID: join.Slot13ID.Int64, Name: join.Slot13Name.String, Path: join.Slot13Path.String}}
	s.engine.Slots[14] = &models.PlayerSlot{ID: 14, AudioFile: db.AudioFile{ID: join.Slot14ID.Int64, Name: join.Slot14Name.String, Path: join.Slot14Path.String}}
	s.engine.Slots[15] = &models.PlayerSlot{ID: 15, AudioFile: db.AudioFile{ID: join.Slot15ID.Int64, Name: join.Slot15Name.String, Path: join.Slot15Path.String}}

	return &pb.PaletteActivateResponse{Success: true}, nil
}

func (s *AudioGRPCServer) SetActiveSlot(ctx context.Context, req *pb.PlayerSlotID) (*pb.PlayerSlot, error) {
	s.engine.Mu.Lock()
	slot := s.engine.Slots[req.Id]
	s.engine.AudioStatus.ActiveSlot = int(req.Id)
	s.engine.Mu.Unlock()
	return &pb.PlayerSlot{Id: slot.ID, File: MapDBAudioFileToPB(slot.AudioFile)}, nil
}
