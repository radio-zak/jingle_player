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
  name, path, duration
) VALUES (
  ?, ?, ?
)
RETURNING *;

-- name: UpdateAudioFile :exec
UPDATE audio_files
set name = ?,
path = ?,
duration = ?
WHERE id = ?;

-- name: DeleteAudioFile :exec
DELETE FROM audio_files
WHERE id = ?;
