class AppException implements Exception {
  final _message;
  final _prefix;
  String get prefix => _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "${_message ?? ""}";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message = ""]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message = ""]) : super(message, "Invalid Input: ");
}

class InvalidResponseException extends AppException {
  InvalidResponseException([String message = "Server returned invalid response"]) : super(message, "Invalid Response: ");
}

class NotFoundException extends AppException {
  NotFoundException([String message = ""]) : super(message, "Not Found");
}

class NetworkConfigurationNotFoundException extends AppException {
  NetworkConfigurationNotFoundException([String message = "Network Configuration Not Found Exception"]) : super(message);
}

class ServerNotReachableException extends AppException {
  ServerNotReachableException([String message = "Error During Communication"]) : super(message);
}
