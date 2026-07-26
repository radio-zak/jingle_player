package config

import (
	"fmt"

	"github.com/knadh/koanf/parsers/yaml"
	"github.com/knadh/koanf/providers/file"
	"github.com/knadh/koanf/v2"
)

// 1. Define Go Structs with `koanf` tags
type Config struct {
	Server   ServerConfig   `koanf:"server"`
	Database DatabaseConfig `koanf:"database"`
	Audio    AudioConfig    `koanf:"audio"`
}

type ServerConfig struct {
	Host string `koanf:"host"`
	Port string `koanf:"port"`
}

type DatabaseConfig struct {
	Driver           string `koanf:"driver"`
	ConnectionString string `koanf:"connection_string"`
}

type AudioConfig struct {
	SampleRate int `koanf:"sample_rate"`
	BufferSize int `koanf:"buffer_size"`
}

// 2. Load Function
func LoadConfig(path string) (*Config, error) {
	// Initialize Koanf instance with a delimiter (typically ".")
	var k = koanf.New(".")

	// Load and parse YAML file
	if err := k.Load(file.Provider(path), yaml.Parser()); err != nil {
		return nil, fmt.Errorf("error loading config file: %w", err)
	}

	// Unmarshal the loaded configuration into our Go struct
	var cfg Config
	if err := k.Unmarshal("", &cfg); err != nil {
		return nil, fmt.Errorf("error unmarshaling config: %w", err)
	}

	return &cfg, nil
}
