import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server failure - when API call fails
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Cache failure - when local storage operation fails
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Network failure - when there's no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

/// Validation failure - when input validation fails
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({required super.message, this.fieldErrors});

  @override
  List<Object?> get props => [message, fieldErrors];
}

/// Authentication failure - when user is not authenticated
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message = 'Authentication required'});
}

/// Not found failure - when resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Resource not found'});
}

/// Unknown failure - for unexpected errors
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unexpected error occurred'});
}
