CREATE TABLE IF NOT EXISTS palettes (
    id INTEGER PRIMARY KEY NOT NULL,
    name text NOT NULL,
    slot_0_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_1_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_2_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_3_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_4_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_5_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_6_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_7_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_8_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_9_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_10_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_11_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_12_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_13_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_14_file REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_15_file REFERENCES audio_files(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS audio_files (
    id INTEGER PRIMARY KEY NOT NULL,
    name text NOT NULL,
    path text NOT NULL,
    duration REAL NOT NULL
);
