

class AppException implements Exception {
  final dynamic message;

  AppException([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}

class AppError extends AppException {
  AppError([dynamic message]) : super(message);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Error";
    return "Error: $message";
  }
}




