class InterNetConnectionException implements Exception {
  final String? message;
  InterNetConnectionException({this.message});
}

class FaildException implements Exception {
  final String? message;
  final int? statusCode;
  FaildException({this.message, this.statusCode});
}

class InternalException implements Exception {
  final String? message;

  InternalException({this.message});
}

class NotFoundException implements Exception {
  final String? message;

  NotFoundException({this.message});
}
