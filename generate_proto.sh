#!/bin/bash
# Generate Python protobuf files from proto definition

uv run python -m grpc_tools.protoc \
    -I./proto \
    --python_out=. \
    --grpc_python_out=. \
    proto/echo.proto
