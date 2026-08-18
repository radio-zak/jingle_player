package config

import (
	"os"
	"path/filepath"
	"testing"
)

func TestLoadConfig_MediaTag(t *testing.T) {
	path := filepath.Join(t.TempDir(), "config.yaml")
	content := []byte(`
server:
  host: "127.0.0.1"
  port: "1"
media:
  directory: "./from-yaml"
database:
  driver: "sqlite"
  connection_string: "file:app.db"
audio:
  sample_rate: 48000
  buffer_size: 1024
`)
	if err := os.WriteFile(path, content, 0o600); err != nil {
		t.Fatal(err)
	}

	cfg, err := LoadConfig(path)
	if err != nil {
		t.Fatal(err)
	}
	if cfg.Media.Directory != "./from-yaml" {
		t.Fatalf("Media.Directory = %q, want %q", cfg.Media.Directory, "./from-yaml")
	}
	if cfg.Database.ConnectionString != "file:app.db" {
		t.Fatalf("Database.ConnectionString = %q, want %q", cfg.Database.ConnectionString, "file:app.db")
	}
}

func TestLoadConfig_MissingFile(t *testing.T) {
	_, err := LoadConfig(filepath.Join(t.TempDir(), "missing.yaml"))
	if err == nil {
		t.Fatal("expected error for missing config file")
	}
}
