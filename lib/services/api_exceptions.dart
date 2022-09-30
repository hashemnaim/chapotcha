import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String? url;
  final String? message;
  final int? statusCode;
  final Response? response;

  ApiException({
    this.url,
    this.message,
    this.response,
    this.statusCode,
  });

  // @override
  // List<Object> get props => throw UnimplementedError();

  @override
  String toString() {
    return message!;
  }
}

class FetchDataException extends ApiException {
  FetchDataException([massege]) : super(message: "Error During Conmmuncation");
}

class BadRequestException extends ApiException {
  BadRequestException([massege]) : super(message: "Bad Request");
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([massege]) : super(message: "Unauthorized");
}

class NotFoundException extends ApiException {
  NotFoundException([massege]) : super(message: "Requested Info Not Found");
}

class ConflictException extends ApiException {
  ConflictException([massege]) : super(message: "Conflict Occurred");
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException([massege])
      : super(message: "Internal Server Error");
}

class CacheException implements Exception {}
