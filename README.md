# Envoy gRPC-JSON Transcoding: ProtoJSON Parsing Quirks

This repo demonstrates unexpected behavior in Envoy's gRPC-JSON transcoder filter when parsing boolean values and wrapper types.

The test harness was generated with Claude Opus 4.5. The behavior documented here was discovered in production and debugged by hand.

## Issues Found

### 1. ScalarBool accepts string values

The transcoder accepts string values like `"yes"`, `"no"`, `"true"`, `"false"` (case-insensitive) for `bool` fields:

```json
{"b": "yes"}   // accepted as true
{"b": "NO"}    // accepted as false
{"b": "TrUe"}  // accepted as true
```

Per the [Proto JSON spec](https://protobuf.dev/programming-guides/json/), bool fields should only accept the JSON literals `true` and `false`.

### 2. Wrapper types accept object form

The transcoder accepts wrapper types (e.g. `google.protobuf.BoolValue`, `google.protobuf.StringValue`) in object form:

```json
{"b": {"value": true}}
{"s": {"value": "hello"}}
```

Per the [Proto JSON spec](https://protobuf.dev/programming-guides/json/), wrapper types should be represented as the underlying JSON scalar directly, not as an object with a `value` field.

### 3. Wrapper types with complex objects default to empty proto message

When a wrapper type receives a JSON object that doesn't follow the `{"value": ...}` structure, the transcoder silently ignores the unrecognized keys and defaults to the proto empty message for that type:

```json
{"b": {"foo": "bar", "baz": 123}}     // BoolValue defaults to false
{"s": {"name": "test", "items": [1]}} // StringValue defaults to ""
{"b": {"value": true, "extra": "x"}}  // Extra keys ignored, value still parsed
```

This means malformed wrapper type payloads won't error—they'll silently produce default values, which can lead to subtle bugs.

## Running the Tests

Start the services:

```bash
docker compose up --build
```

Run the test script:

```bash
./test.sh
```

## Architecture

- **grpc-server**: Python gRPC server (port 50051)
- **envoy**: Envoy proxy with grpc-json transcoder (port 8080)
- **proto-gen**: Generates proto descriptor for Envoy
