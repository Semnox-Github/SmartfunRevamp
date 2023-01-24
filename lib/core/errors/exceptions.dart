class ServerException implements Exception {
  final String message;
  final Exception? exception;

  ServerException(this.message, {this.exception});
}
