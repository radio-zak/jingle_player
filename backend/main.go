package main

import (
	"encoding/json"
	"fmt"
	"io"
	"jingle_player_backend/internal/audio_engine"
	"jingle_player_backend/internal/control"
	"jingle_player_backend/internal/pb"
	"net"
	"os"
	"strconv"

	"github.com/gordonklaus/portaudio"
	"google.golang.org/grpc"
)

func main() {
	fmt.Println("Hello world!")

	readConfigFromDisk()

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
	handler := control.NewAudioGRPCServer(audio)
	pb.RegisterAudioServiceServer(grpcs, handler)

	fmt.Println("Listening on port :6969")
	err = grpcs.Serve(listener)
	if err != nil {
		fmt.Println("Failed to create gRPC server on port :6969", err)
		return
	}

}

type AppConfig struct {
	AppTitle       string `json:"appTitle"`
	PlayerCount    int    `json:"playerCount"`
	PaletteCount   int    `json:"paletteCount"`
	MediaDirectory string `json:"mediaDirectory"`
}

func readConfigFromDisk() {
	jsonFile, err := os.Open("./config.json")
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("Reading config file from disk")

	byteValue, err := io.ReadAll(jsonFile)
	if err != nil {
		fmt.Println("Error reading file", err)
		return
	}
	var config AppConfig

	err = json.Unmarshal(byteValue, &config)
	if err != nil {
		fmt.Println("Failed unmarshaling json", err)
		return
	}
	fmt.Println(config)
	fmt.Println("App title: " + config.AppTitle)
	fmt.Println("Palette count: " + strconv.Itoa(config.PaletteCount))
	fmt.Println("Media dir: " + config.MediaDirectory)

	defer jsonFile.Close()
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
