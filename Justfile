generate-proto: 
    protoc --dart_out=grpc:frontend/lib/control control.proto 
    protoc --go_out=backend/internal/pb --go_opt=paths=source_relative --go-grpc_out=backend/internal/pb --go-grpc_opt=paths=source_relative control.proto