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
	"time"

	"google.golang.org/grpc"
	_ "modernc.org/sqlite"
)

//go:embed db/schema.sql
var ddl string

const grpcShutdownTimeout = 5 * time.Second

func main() {
	cfg, err := config.LoadConfig("config.yaml")
	if err != nil {
		log.Fatalf("Failed opening config file: %v", err)
	}

	if cfg.Media.Directory == "" {
		log.Fatal("media.directory is empty")
	}
	if err := os.MkdirAll(cfg.Media.Directory, 0o750); err != nil {
		log.Fatalf("Failed creating media directory: %v", err)
	}

	ctx := context.Background()
	datastore, err := sql.Open(cfg.Database.Driver, cfg.Database.ConnectionString)
	if err != nil {
		log.Fatalf("Failed opening database with driver %v: %v", cfg.Database.Driver, err)
	}
	defer datastore.Close()

	if err := datastore.PingContext(ctx); err != nil {
		log.Fatalf("Failed connecting to database: %v", err)
	}
	if err := enableSQLitePragmas(ctx, datastore); err != nil {
		log.Fatalf("Failed applying SQLite pragmas: %v", err)
	}

	if _, err := datastore.ExecContext(ctx, ddl); err != nil {
		log.Fatalf("Failed applying schema: %v", err)
	}

	queries := db.New(datastore)

	audio, err := audio_engine.InitPlayer(cfg)
	if err != nil {
		log.Fatalf("Failed initializing audio engine: %v", err)
	}

	ver := audio.GetVersion()
	log.Println(ver)

	grpcs := grpc.NewServer()
	handler := control.NewAudioGRPCServer(audio, queries, cfg)
	pb.RegisterAudioServiceServer(grpcs, handler)

	listenAddr := strings.Join([]string{cfg.Server.Host, cfg.Server.Port}, ":")
	listener, err := net.Listen("tcp", listenAddr)
	if err != nil {
		if closeErr := audio.Close(); closeErr != nil {
			log.Printf("Error closing audio engine: %v", closeErr)
		}
		log.Fatalf("Failed to listen on address %v: %v", listenAddr, err)
	}

	serveErr := make(chan error, 1)
	go func() {
		log.Println("Listening on", listenAddr)
		serveErr <- grpcs.Serve(listener)
	}()

	sigCtx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	select {
	case <-sigCtx.Done():
		log.Println("Shutting down...")
	case err := <-serveErr:
		if err != nil {
			log.Printf("gRPC server error: %v", err)
		}
	}

	if err := audio.Close(); err != nil {
		log.Printf("Error closing audio engine: %v", err)
	}
	gracefulStop(grpcs, grpcShutdownTimeout)
}

func enableSQLitePragmas(ctx context.Context, db *sql.DB) error {
	pragmas := []string{
		"PRAGMA foreign_keys = ON",
		"PRAGMA busy_timeout = 5000",
		"PRAGMA journal_mode = WAL",
	}
	for _, pragma := range pragmas {
		if _, err := db.ExecContext(ctx, pragma); err != nil {
			return fmt.Errorf("%s: %w", pragma, err)
		}
	}
	return nil
}

func gracefulStop(grpcs *grpc.Server, timeout time.Duration) {
	stopped := make(chan struct{})
	go func() {
		grpcs.GracefulStop()
		close(stopped)
	}()
	select {
	case <-stopped:
	case <-time.After(timeout):
		log.Println("gRPC graceful stop timed out, forcing stop")
		grpcs.Stop()
	}
}
