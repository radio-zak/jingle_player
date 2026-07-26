package control

import (
	"database/sql"
	"jingle_player_backend/internal/db"
	"jingle_player_backend/internal/pb"
)

// Helper to convert nullable db fields into a *pb.AudioFile pointer
func mapDBToAudioFile(id sql.NullInt64, path sql.NullString, name sql.NullString) *pb.AudioFile {
	if !id.Valid {
		return nil // Slot is empty, return nil for the nested AudioFile
	}

	return &pb.AudioFile{
		Id:       int32(id.Int64),
		FilePath: path.String,
		FileName: name.String,
		// Populate other fields if fetched from JOIN query
	}
}

// Helper to build a single PlayerSlot
func makeSlot(slotNum int32, audioID sql.NullInt64, audioPath sql.NullString, audioName sql.NullString) *pb.PlayerSlot {
	return &pb.PlayerSlot{
		Id:   slotNum,
		File: mapDBToAudioFile(audioID, audioPath, audioName),
	}
}

func MapDBPaletteToPB(d db.Palette) *pb.Palette {
	if !d.Slot0File.Valid {
		return nil
	}
	// Pre-allocate slice for exactly 16 slots
	slots := make([]*pb.PlayerSlot, 16)

	// Construct 16 slot items (assuming flat db.Palette struct)
	slots[0] = makeSlot(1, d.Slot0File, sql.NullString{}, sql.NullString{})
	slots[1] = makeSlot(2, d.Slot1File, sql.NullString{}, sql.NullString{})
	slots[2] = makeSlot(3, d.Slot2File, sql.NullString{}, sql.NullString{})
	slots[3] = makeSlot(4, d.Slot3File, sql.NullString{}, sql.NullString{})
	slots[4] = makeSlot(5, d.Slot4File, sql.NullString{}, sql.NullString{})
	slots[5] = makeSlot(6, d.Slot5File, sql.NullString{}, sql.NullString{})
	slots[6] = makeSlot(7, d.Slot6File, sql.NullString{}, sql.NullString{})
	slots[7] = makeSlot(8, d.Slot7File, sql.NullString{}, sql.NullString{})
	slots[8] = makeSlot(9, d.Slot8File, sql.NullString{}, sql.NullString{})
	slots[9] = makeSlot(10, d.Slot9File, sql.NullString{}, sql.NullString{})
	slots[10] = makeSlot(11, d.Slot10File, sql.NullString{}, sql.NullString{})
	slots[11] = makeSlot(12, d.Slot11File, sql.NullString{}, sql.NullString{})
	slots[12] = makeSlot(13, d.Slot12File, sql.NullString{}, sql.NullString{})
	slots[13] = makeSlot(14, d.Slot13File, sql.NullString{}, sql.NullString{})
	slots[14] = makeSlot(15, d.Slot14File, sql.NullString{}, sql.NullString{})
	slots[15] = makeSlot(16, d.Slot15File, sql.NullString{}, sql.NullString{})

	return &pb.Palette{
		Id:    int32(d.ID),
		Name:  d.Name,
		Slots: slots,
	}
}

func MapDBPalettesToPB(dbPalettes []db.Palette) []*pb.Palette {
	if len(dbPalettes) == 0 {
		return []*pb.Palette{}
	}

	pbPalettes := make([]*pb.Palette, len(dbPalettes))
	for i := range dbPalettes {
		pbPalettes[i] = MapDBPaletteToPB(dbPalettes[i])
	}

	return pbPalettes
}

func Int32ToSqlNullInt64(val int32) sql.NullInt64 {
	return sql.NullInt64{Valid: true, Int64: int64(val)}
}
func Int64ToSqlNullInt64(val int64) sql.NullInt64 {
	return sql.NullInt64{Valid: true, Int64: int64(val)}
}

func MapDBAudioFileToPB(f db.AudioFile) *pb.AudioFile {
	return &pb.AudioFile{Id: int32(f.ID), FileName: f.Name, FilePath: f.Path}
}

func MapDBAudioFilesToPB(dbFiles []db.AudioFile) []*pb.AudioFile {
	if len(dbFiles) == 0 {
		return []*pb.AudioFile{}
	}
	files := make([]*pb.AudioFile, len(dbFiles))
	for i := range files {
		files[i] = MapDBAudioFileToPB(dbFiles[i])
	}
	return files
}

// Helper to construct a db.AudioFile from joined row fields
func parseJoinedAudioFile(id sql.NullInt64, name, path sql.NullString, duration sql.NullFloat64) (db.AudioFile, bool) {
	if !id.Valid || id.Int64 == 0 {
		return db.AudioFile{}, false // Empty slot
	}

	return db.AudioFile{
		ID:       id.Int64, // DB Primary Key (e.g., 42)
		Name:     name.String,
		Path:     path.String,
		Duration: duration.Float64,
	}, true
}
