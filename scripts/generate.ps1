# generate.ps1 - Windows
$ErrorActionPreference = "Stop"

Write-Host "Generando código protobuf..."

# Configurar rutas
$PROJECT_ROOT = Split-Path -Parent $MyInvocation.MyCommand.Path
$OUTPUT_DIR = Join-Path $PROJECT_ROOT "gen/pb"

# Limpiar y crear directorios
Remove-Item -Path $OUTPUT_DIR -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $OUTPUT_DIR -Force | Out-Null

# Verificar protoc
try {
    protoc --version | Out-Null
} catch {
    Write-Host "ERROR: protoc no está instalado" -ForegroundColor Red
    Write-Host "Instalar desde: https://github.com/protocolbuffers/protobuf/releases"
    exit 1
}

# Generar código
$PROTO_FILE = Join-Path $PROJECT_ROOT "proto/osmi.proto"
protoc -I="$PROJECT_ROOT/proto" `
    --go_out="$OUTPUT_DIR" --go_opt=paths=source_relative `
    --go-grpc_out="$OUTPUT_DIR" --go-grpc_opt=paths=source_relative `
    --grpc-gateway_out="$OUTPUT_DIR" `
    --grpc-gateway_opt=paths=source_relative `
    --grpc-gateway_opt=logtostderr=true `
    --openapiv2_out="$OUTPUT_DIR" `
    --openapiv2_opt=logtostderr=true `
    $PROTO_FILE

Write-Host "Código generado en: $OUTPUT_DIR" -ForegroundColor Green