import 'package:dio/dio.dart';

enum ExceptionType {
  badRequest,
  internalServer,
  conflict,
  unauthorized,
  forbidden,
  notFound,
  noInternetConnection,
  deadlineExceeded,
  unknown
}

class RestException extends DioError {
  RestException(
      {required RequestOptions request,
      DioError? error,
      this.status,
      this.responseMessage = 'Something went wrong',
      this.exceptionType = ExceptionType.unknown})
      : super(
            requestOptions: request,
            error: error,
            response: error?.response,
            type: error?.type ?? DioErrorType.other);

  final String? status;
  final String responseMessage;
  final ExceptionType exceptionType;

  static ExceptionType getExceptionType(int? statusCode) {
    switch (statusCode) {
      case 400:
        return ExceptionType.badRequest;
      case 401:
        return ExceptionType.unauthorized;
      case 403:
        // Valid credentials but no privilege to perform the action
        return ExceptionType.forbidden;
      case 404:
        return ExceptionType.notFound;
      case 409:
        return ExceptionType.conflict;
      case 500:
        return ExceptionType.internalServer;
      default:
        return ExceptionType.unknown;
    }
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': responseMessage};

  factory RestException.fromResponse(Response response, {DioError? error}) {
    try {
      final responseMessage = response.data['message'] ?? '';
      return RestException(
          request: response.requestOptions,
          error: error,
          status: response.statusCode.toString(),
          responseMessage: responseMessage,
          exceptionType: getExceptionType(response.statusCode));
    } catch (error) {
      return RestException(
          request: response.requestOptions,
          status: response.statusCode.toString(),
          responseMessage: 'Unknown Error');
    }
  }

  @override
  String toString() {
    return 'RestException: ${toJson().toString()}';
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
