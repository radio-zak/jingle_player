CREATE TABLE IF NOT EXISTS palettes (
    id INTEGER PRIMARY KEY NOT NULL,
    name text NOT NULL,
    slot_0_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_1_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_2_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_3_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_4_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_5_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_6_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_7_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_8_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_9_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_10_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_11_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_12_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_13_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_14_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL,
    slot_15_file INTEGER REFERENCES audio_files(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS audio_files (
    id INTEGER PRIMARY KEY NOT NULL,
    name text NOT NULL,
    path text NOT NULL,
    duration REAL NOT NULL
);
