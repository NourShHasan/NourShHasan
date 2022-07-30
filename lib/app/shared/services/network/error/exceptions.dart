class ServerException implements Exception {
  final String? message;
  final String? messageKey;
  ServerException({this.message, this.messageKey});
}

class BadRequestException implements Exception {
  final String? message;
  final String? messageKey;
  final double? daysLeft;
  BadRequestException({this.message, this.messageKey, this.daysLeft = 0});
}

class UnAuthorizationException implements Exception {
  final String? message;
  final String? messageKey;

  UnAuthorizationException({this.message, this.messageKey});
}

class CacheException implements Exception {}

class NotFoundException implements Exception {
  final String? message;
  final String? messageKey;

  NotFoundException({this.message, this.messageKey});
}

class NoInternetConnectionException implements Exception {}
