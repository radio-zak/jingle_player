-- name: AudioFileNameExists :one
SELECT EXISTS(
    SELECT 1 FROM audio_files WHERE name = ?
) AS name_exists;


-- name: PaletteNameExists :one 
SELECT EXISTS(
  SELECT 1 FROM palettes WHERE name = ?
) AS name_exists;

-- name: GetPalette :one
SELECT * FROM palettes
WHERE id = ? LIMIT 1;

-- name: ListPalettes :many
SELECT * FROM palettes
ORDER BY name;

-- name: CreatePalette :one
INSERT INTO palettes (
  name, slot_0_file, slot_1_file, slot_2_file, slot_3_file, slot_4_file, slot_5_file, slot_6_file, slot_7_file, slot_8_file, slot_9_file, slot_10_file,
  slot_11_file, slot_12_file, slot_13_file, slot_14_file, slot_15_file
) VALUES (
  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
)
RETURNING *;

-- name: UpdatePalette :exec
UPDATE palettes
set name = ?,
slot_0_file = ?,
slot_1_file = ?,
slot_2_file = ?,
slot_3_file = ?,
slot_4_file = ?,
slot_5_file = ?,
slot_6_file = ?,
slot_7_file = ?,
slot_8_file = ?,
slot_9_file = ?,
slot_10_file = ?,
slot_11_file = ?,
slot_12_file = ?,
slot_13_file = ?,
slot_14_file = ?,
slot_15_file = ?
WHERE id = ?;

-- name: DeletePalette :exec
DELETE FROM palettes
WHERE id = ?;

-- name: GetAudioFile :one
SELECT * FROM audio_files
WHERE id = ? LIMIT 1;

-- name: ListAudioFiles :many
SELECT * FROM audio_files
ORDER BY name;

-- name: CreateAudioFile :one
INSERT INTO audio_files (
  name, size, duration
) VALUES (
  ?, ?, ?
)
RETURNING *;

-- name: UpdateAudioFile :exec
UPDATE audio_files
set name = ?,
size = ?,
duration = ?
WHERE id = ?;

-- name: DeleteAudioFile :exec
DELETE FROM audio_files
WHERE id = ?;

-- name: GetPaletteWithAudioFiles :one
SELECT 
    p.id AS palette_id,
    p.name AS palette_name,

    -- Slot 0 (Index 0)
    a0.id AS slot_0_id, a0.name AS slot_0_name, a0.size AS slot_0_size, a0.duration AS slot_0_duration,
    -- Slot 1 (Index 1)
    a1.id AS slot_1_id, a1.name AS slot_1_name, a1.size AS slot_1_size, a1.duration AS slot_1_duration,
    -- Slot 2 (Index 2)
    a2.id AS slot_2_id, a2.name AS slot_2_name, a2.size AS slot_2_size, a2.duration AS slot_2_duration,
    -- Slot 3 (Index 3)
    a3.id AS slot_3_id, a3.name AS slot_3_name, a3.size AS slot_3_size, a3.duration AS slot_3_duration,
    -- Slot 4 (Index 4)
    a4.id AS slot_4_id, a4.name AS slot_4_name, a4.size AS slot_4_size, a4.duration AS slot_4_duration,
    -- Slot 5 (Index 5)
    a5.id AS slot_5_id, a5.name AS slot_5_name, a5.size AS slot_5_size, a5.duration AS slot_5_duration,
    -- Slot 6 (Index 6)
    a6.id AS slot_6_id, a6.name AS slot_6_name, a6.size AS slot_6_size, a6.duration AS slot_6_duration,
    -- Slot 7 (Index 7)
    a7.id AS slot_7_id, a7.name AS slot_7_name, a7.size AS slot_7_size, a7.duration AS slot_7_duration,
    -- Slot 8 (Index 8)
    a8.id AS slot_8_id, a8.name AS slot_8_name, a8.size AS slot_8_size, a8.duration AS slot_8_duration,
    -- Slot 9 (Index 9)
    a9.id AS slot_9_id, a9.name AS slot_9_name, a9.size AS slot_9_size, a9.duration AS slot_9_duration,
    -- Slot 10 (Index 10)
    a10.id AS slot_10_id, a10.name AS slot_10_name, a10.size AS slot_10_size, a10.duration AS slot_10_duration,
    -- Slot 11 (Index 11)
    a11.id AS slot_11_id, a11.name AS slot_11_name, a11.size AS slot_11_size, a11.duration AS slot_11_duration,
    -- Slot 12 (Index 12)
    a12.id AS slot_12_id, a12.name AS slot_12_name, a12.size AS slot_12_size, a12.duration AS slot_12_duration,
    -- Slot 13 (Index 13)
    a13.id AS slot_13_id, a13.name AS slot_13_name, a13.size AS slot_13_size, a13.duration AS slot_13_duration,
    -- Slot 14 (Index 14)
    a14.id AS slot_14_id, a14.name AS slot_14_name, a14.size AS slot_14_size, a14.duration AS slot_14_duration,
    -- Slot 15 (Index 15)
    a15.id AS slot_15_id, a15.name AS slot_15_name, a15.size AS slot_15_size, a15.duration AS slot_15_duration

FROM palettes p
LEFT JOIN audio_files a0  ON p.slot_0_file  = a0.id
LEFT JOIN audio_files a1  ON p.slot_1_file  = a1.id
LEFT JOIN audio_files a2  ON p.slot_2_file  = a2.id
LEFT JOIN audio_files a3  ON p.slot_3_file  = a3.id
LEFT JOIN audio_files a4  ON p.slot_4_file  = a4.id
LEFT JOIN audio_files a5  ON p.slot_5_file  = a5.id
LEFT JOIN audio_files a6  ON p.slot_6_file  = a6.id
LEFT JOIN audio_files a7  ON p.slot_7_file  = a7.id
LEFT JOIN audio_files a8  ON p.slot_8_file  = a8.id
LEFT JOIN audio_files a9  ON p.slot_9_file  = a9.id
LEFT JOIN audio_files a10 ON p.slot_10_file = a10.id
LEFT JOIN audio_files a11 ON p.slot_11_file = a11.id
LEFT JOIN audio_files a12 ON p.slot_12_file = a12.id
LEFT JOIN audio_files a13 ON p.slot_13_file = a13.id
LEFT JOIN audio_files a14 ON p.slot_14_file = a14.id
LEFT JOIN audio_files a15 ON p.slot_15_file = a15.id
WHERE p.id = ? LIMIT 1;