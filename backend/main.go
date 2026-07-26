package main

import (
	"context"
	"database/sql"
	_ "embed"
	"encoding/json"
	"fmt"
	"jingle_player_backend/internal/audio_engine"
	"jingle_player_backend/internal/control"
	"jingle_player_backend/internal/db"
	"jingle_player_backend/internal/pb"
	"net"
	"os"

	"github.com/gordonklaus/portaudio"
	"google.golang.org/grpc"
	_ "modernc.org/sqlite"
)

//go:embed db/schema.sql
var ddl string

func main() {
	ctx := context.Background()
	datastore, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		panic(err)
	}
	defer datastore.Close()

	if _, err := datastore.ExecContext(ctx, ddl); err != nil {
		panic(err)
	}

	queries := db.New(datastore)

	audio, err := audio_engine.InitPlayer()
	if err != nil {
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
	listener, err := net.Listen("tcp", ":6969")
	if err != nil {
		fmt.Println("Failed to listen on port :6969", err)
		return
	}
	grpcs := grpc.NewServer()
	handler := control.NewAudioGRPCServer(audio, queries)
	pb.RegisterAudioServiceServer(grpcs, handler)

	fmt.Println("Listening on port :6969")
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
