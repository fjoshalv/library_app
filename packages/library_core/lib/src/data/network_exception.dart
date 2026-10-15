sealed class NetworkException implements Exception {}

final class NoConnection extends NetworkException {}

final class HttpError(this.statusCode) extends NetworkException {
  final int? statusCode;

  @override
  String toString() {
    return "HTTP Error: $statusCode";
  }
}

final class DecodingError(this.cause) extends NetworkException {
  final Object cause;

  @override
  String toString() => 'Decoding Error: $cause';
}

final class CancelledRequest extends NetworkException {}

final class UnknownNetworkError(this.cause) extends NetworkException {
  final Object cause;

  @override
  String toString() => 'UnknownNetworkError: $cause';
}
