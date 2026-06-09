#!/bin/bash
echo "Generando código protobuf..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEN_DIR="$SCRIPT_DIR/gen"

rm -rf "$GEN_DIR"
mkdir -p "$GEN_DIR"

echo "Generando osmi.proto..."
protoc -I"$SCRIPT_DIR/proto" \
       -I"$SCRIPT_DIR/third_party/googleapis" \
       --go_out="$GEN_DIR" \
       --go_opt=module=github.com/franciscozamorau/osmi-protobuf \
       --go-grpc_out="$GEN_DIR" \
       --go-grpc_opt=module=github.com/franciscozamorau/osmi-protobuf \
       --grpc-gateway_out="$GEN_DIR" \
       --grpc-gateway_opt=module=github.com/franciscozamorau/osmi-protobuf \
       "$SCRIPT_DIR/proto/osmi.proto"

echo "Código generado en $GEN_DIR"
ls -la "$GEN_DIR"