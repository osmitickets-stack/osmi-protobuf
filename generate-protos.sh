#!/bin/bash
echo "Generando código protobuf..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEN_DIR="$SCRIPT_DIR/gen"

rm -rf "$GEN_DIR"
mkdir -p "$GEN_DIR/pb"

echo "Generando osmi.proto..."

protoc \
  -I"$SCRIPT_DIR/proto" \
  -I"$SCRIPT_DIR/third_party/googleapis" \
  --go_out="$GEN_DIR" \
  --go_opt=paths=source_relative \
  --go-grpc_out="$GEN_DIR" \
  --go-grpc_opt=paths=source_relative \
  --grpc-gateway_out="$GEN_DIR" \
  --grpc-gateway_opt=paths=source_relative \
  "$SCRIPT_DIR/proto/osmi.proto"

mv "$GEN_DIR/"*.pb.go "$GEN_DIR/pb/"
mv "$GEN_DIR/"*.pb.gw.go "$GEN_DIR/pb/"

echo "Código generado en $GEN_DIR/pb"
ls -la "$GEN_DIR/pb"