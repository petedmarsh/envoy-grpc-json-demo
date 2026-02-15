"""Simple gRPC Echo server that echoes back ScalarBool messages."""

import grpc
from concurrent import futures

import echo_pb2
import echo_pb2_grpc


class EchoServicer(echo_pb2_grpc.EchoServicer):
    """Echo service implementation."""

    def EchoScalarBool(self, request, context):
        """Echo back the ScalarBool message."""
        print(f"Received: b={request.b}")
        return echo_pb2.ScalarBool(b=request.b)

    def EchoStringValue(self, request, context):
        """Echo back the StringValue message."""
        print(f"Received: s={request.s}")
        return echo_pb2.StringValue(s=request.s)

    def EchoBoolValue(self, request, context):
        """Echo back the BoolValue message."""
        print(f"Received: b={request.b}")
        return echo_pb2.BoolValue(b=request.b)


def serve():
    """Start the gRPC server."""
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    echo_pb2_grpc.add_EchoServicer_to_server(EchoServicer(), server)
    server.add_insecure_port("[::]:50051")
    print("Server started on port 50051")
    server.start()
    server.wait_for_termination()


if __name__ == "__main__":
    serve()
