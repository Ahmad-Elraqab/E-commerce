import 'dart:async';
import 'package:taxi_client_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:taxi_client_app/app/data_sources/remote/custom_dio_error.dart';
import 'package:dio/dio.dart';

// Good article to refer on dio 401 error
// https://krishanmadushankadev.medium.com/how-to-handle-401-unauthorised-with-dio-interceptor-flutter-60398a914406

// This code is based on
// https://medium.com/dreamwod-tech/flutter-dio-framework-best-practices-668985fc75b7
class AppInterceptors extends QueuedInterceptor {
  AppInterceptors({required this.dio, required AuthTokenStorage authTokenStorage})
    : _authTokenStorage = authTokenStorage;
  final Dio dio;
  final AuthTokenStorage _authTokenStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // if (response.headers['Guest-Token'] != null) {
    //   final guestToken = response.headers['Guest-Token']?.firstOrNull;
    //   if (guestToken != null && guestToken != 'null') {
    //     // await _authTokenStorage.saveGuestToken(guestToken);
    //   }
    // }

    return handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return handler.next(
          RestException(
            request: err.requestOptions,
            error: err,
            responseMessage: 'The connection has timed out, please try again.',
            exceptionType: ExceptionType.deadlineExceeded,
          ),
        );

      case DioErrorType.response:
        if (err.response!.statusCode != null) {
          if (err.response!.statusCode == 401) {
            return handler.next(
              RestException(
                request: err.requestOptions,
                error: err,
                responseMessage: err.response?.data['message'] ?? "error",
                exceptionType: ExceptionType.unauthorized,
              ),
            );
          } else {
            return handler.next(
              RestException(
                request: err.requestOptions,
                error: err,
                responseMessage: err.response?.data['message'] ?? "error",
                exceptionType: ExceptionType.unknown,
              ),
            );
          }
        }
        break;

      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        return handler.next(
          RestException(
            request: err.requestOptions,
            error: err,
            responseMessage: 'No internet connection detected, please try again.',
            exceptionType: ExceptionType.noInternetConnection,
          ),
        );

      default:
        return handler.next(
          RestException(
            request: err.requestOptions,
            error: err,
            responseMessage: err.response?.data['message'] ?? "error",
            exceptionType: ExceptionType.noInternetConnection,
          ),
        );
    }

    return handler.next(err);
  }
}
