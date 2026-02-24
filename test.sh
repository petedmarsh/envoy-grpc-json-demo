#!/bin/bash
# Test the gRPC-JSON transcoding via Envoy

ENDPOINT="http://localhost:8080"

echo "=== ScalarBool Tests ==="
echo ""

echo "Testing EchoScalarBool with b=true:"
curl -s -H "content-type: application/json" -d '{"b": true}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo "Testing EchoScalarBool with b=false:"
curl -s -H "content-type: application/json" -d '{"b": false}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo "Testing EchoScalarBool with b=\"yes\":"
curl -s -H "content-type: application/json" -d '{"b": "yes"}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo "Testing EchoScalarBool with b=\"no\":"
curl -s -H "content-type: application/json" -d '{"b": "no"}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo "Testing EchoScalarBool with b=\"true\":"
curl -s -H "content-type: application/json" -d '{"b": "true"}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo "Testing EchoScalarBool with b=\"false\":"
curl -s -H "content-type: application/json" -d '{"b": "false"}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo "Testing EchoScalarBool with b=\"TrUe\":"
curl -s -H "content-type: application/json" -d '{"b": "TrUe"}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo "Testing EchoScalarBool with b=\"NO\":"
curl -s -H "content-type: application/json" -d '{"b": "NO"}' "$ENDPOINT/example.Echo/EchoScalarBool"
echo ""

echo ""
echo "=== BoolValue (wrapper) Tests ==="
echo ""

echo "Testing EchoBoolValue with b={value: true}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": true}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoBoolValue with b={value: false}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": false}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoBoolValue with b={value: \"yes\"}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": "yes"}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoBoolValue with b={value: \"no\"}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": "no"}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoBoolValue with b={value: \"true\"}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": "true"}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoBoolValue with b={value: \"false\"}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": "false"}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoBoolValue with b={value: \"TrUe\"}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": "TrUe"}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoBoolValue with b={value: \"NO\"}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": "NO"}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo ""
echo "=== StringValue Tests ==="
echo ""

echo "Testing EchoStringValue with s={value: \"oh no\"}:"
curl -s -H "content-type: application/json" -d '{"s": {"value": "oh no"}}' "$ENDPOINT/example.Echo/EchoStringValue"
echo ""

echo ""
echo "=== Wrapper Type with Complex Object (non-{value: ...} form) Tests ==="
echo ""
echo "When a wrapper type receives a complex JSON object with keys other than 'value',"
echo "the wrapper defaults to the empty proto message for that type."
echo ""

echo "Testing EchoBoolValue with b={foo: \"bar\", baz: 123, nested: {key: \"val\"}}:"
curl -s -H "content-type: application/json" -d '{"b": {"foo": "bar", "baz": 123, "nested": {"key": "val"}}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""

echo "Testing EchoStringValue with s={name: \"test\", count: 42, items: [1, 2, 3]}:"
curl -s -H "content-type: application/json" -d '{"s": {"name": "test", "count": 42, "items": [1, 2, 3]}}' "$ENDPOINT/example.Echo/EchoStringValue"
echo ""

echo "Testing EchoBoolValue with b={value: true, extra: \"ignored\"}:"
curl -s -H "content-type: application/json" -d '{"b": {"value": true, "extra": "ignored"}}' "$ENDPOINT/example.Echo/EchoBoolValue"
echo ""
