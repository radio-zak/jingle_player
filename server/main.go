package main

import (
	"context"
	"database/sql"
	"djinn_server/internal/audio_engine"
	"djinn_server/internal/config"
	"djinn_server/internal/control"
	"djinn_server/internal/db"
	"djinn_server/internal/pb"
	_ "embed"
	"fmt"
	"log"
	"net"
	"os"
	"os/signal"
	"strings"
	"syscall"

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

	_, err = os.Stat(cfg.Media.Directory)
	if os.IsNotExist(err) {
		fmt.Println("Media directory does not exist, creating...")
		err = os.Mkdir(cfg.Media.Directory, 0777)
		if err != nil {
			log.Fatalf("Failed creating media directory %v", err)
			panic(err)
		}
	}

	ctx := context.Background()
	datastore, err := sql.Open(cfg.Database.Driver, "test.db")
	if err != nil {
		log.Fatalf("Failed opening database with driver %v: %v", cfg.Database.Driver, err)
		panic(err)
	}
	defer datastore.Close()

	if _, err := datastore.ExecContext(ctx, ddl); err != nil {
		panic(err)
	}

	queries := db.New(datastore)

	audio, err := audio_engine.InitPlayer(cfg)
	if err != nil {
		log.Fatalf("Failed initializing audio engine: %v", err)
		panic(err)
	}
	defer audio.Close()

	ver := audio.GetVersion()
	fmt.Println(ver)

	grpcs := grpc.NewServer()
	handler := control.NewAudioGRPCServer(audio, queries, cfg)
	pb.RegisterAudioServiceServer(grpcs, handler)
	go func() {
		listenAddr := strings.Join([]string{cfg.Server.Host, cfg.Server.Port}, ":")
		listener, err := net.Listen("tcp", listenAddr)
		if err != nil {
			log.Fatalf("Failed to listen on address %v: %v", listenAddr, err)
			panic(err)
		}
		fmt.Println("Listening on", listenAddr)
		grpcs.Serve(listener)
		if err != nil {
			fmt.Println("Failed to create gRPC server on address", listenAddr, err)
			return
		}
	}()
	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	// Block main until a signal is received (e.g. Ctrl+C or Docker/Kubernetes SIGTERM)
	<-ctx.Done()

	log.Println("Shutting down...")
	grpcs.GracefulStop()
}
