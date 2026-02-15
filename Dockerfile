FROM python:3.11-slim

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Copy proto files
COPY proto/ proto/

# Install dependencies
RUN uv pip install --system grpcio grpcio-tools googleapis-common-protos

# Generate proto files
RUN python -m grpc_tools.protoc \
    -I./proto \
    --python_out=. \
    --grpc_python_out=. \
    proto/echo.proto

# Copy server code
COPY server.py .

CMD ["python", "server.py"]
