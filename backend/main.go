package main

import (
	"context"
	"database/sql"
	_ "embed"
	"encoding/json"
	"fmt"
	"jingle_player_backend/internal/audio_engine"
	"jingle_player_backend/internal/config"
	"jingle_player_backend/internal/control"
	"jingle_player_backend/internal/db"
	"jingle_player_backend/internal/pb"
	"log"
	"net"
	"os"
	"strings"

	"github.com/gordonklaus/portaudio"
	"google.golang.org/grpc"
	_ "modernc.org/sqlite"
)

//go:embed db/schema.sql
var ddl string

func main() {
	cfg, err := config.LoadConfig("config.yaml")
	if err != nil {
		log.Fatalf("Failed opening config file: %v", err)
		panic(err)
	}

	ctx := context.Background()
	datastore, err := sql.Open(cfg.Database.Driver, ":memory:")
	if err != nil {
		log.Fatalf("Failed opening database with driver %v: %v", cfg.Database.Driver, err)
		panic(err)
	}
	defer datastore.Close()

	if _, err := datastore.ExecContext(ctx, ddl); err != nil {
		panic(err)
	}

	queries := db.New(datastore)

	audio, err := audio_engine.InitPlayer(cfg.Audio.SampleRate, cfg.Audio.BufferSize)
	if err != nil {
		log.Fatalf("Failed initializing audio engine: %v", err)
		panic(err)
	}

	ver := audio.GetVersion()
	fmt.Println(ver)

	// dev, err := audio.EnumDevices()
	// if err != nil {
	// 	fmt.Println("Failed to enumerate devices", err)
	// 	return
	// }
	// deviceInfoToJSON(dev)
	listenAddr := strings.Join([]string{cfg.Server.Host, cfg.Server.Port}, ":")
	listener, err := net.Listen("tcp", listenAddr)
	if err != nil {
		log.Fatalf("Failed to listen on address %v: %v", listenAddr, err)
		panic(err)
	}
	grpcs := grpc.NewServer()
	handler := control.NewAudioGRPCServer(audio, queries)
	pb.RegisterAudioServiceServer(grpcs, handler)

	fmt.Println("Listening on", listenAddr)
	err = grpcs.Serve(listener)
	if err != nil {
		fmt.Println("Failed to create gRPC server on port :6969", err)
		return
	}

}

type JSONDevice struct {
	ID                int     `json:"id"`
	Name              string  `json:"name"`
	HostAPI           string  `json:"host_api"`
	MaxInputChannels  int     `json:"max_input_channels"`
	MaxOutputChannels int     `json:"max_output_channels"`
	DefaultSampleRate float64 `json:"default_sample_rate"`
}

func deviceInfoToJSON(dev []*portaudio.DeviceInfo) {

	var jsonDevices []JSONDevice

	for i, dev := range dev {

		jsonDevices = append(jsonDevices, JSONDevice{
			ID:                i,
			Name:              dev.Name,
			HostAPI:           dev.HostApi.Name,
			MaxInputChannels:  dev.MaxInputChannels,
			MaxOutputChannels: dev.MaxOutputChannels,
			DefaultSampleRate: dev.DefaultSampleRate,
		})
	}

	jsonBytes, err := json.MarshalIndent(jsonDevices, "", "  ")
	if err != nil {
		fmt.Println("{\"error\": \"Failed to generate JSON: %v\"}\n", err)
		return
	}

	// 5. Print it straight to standard output
	os.Stdout.Write(jsonBytes)
	fmt.Println()
}
