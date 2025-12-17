/// Base class for all exceptions in the application
class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => 'AppException: $message';
}

/// Server exception - thrown when API call fails
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

/// Cache exception - thrown when local storage operation fails
class CacheException extends AppException {
  const CacheException({required super.message});
}

/// Network exception - thrown when there's no internet connection
class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection'});
}

/// Authentication exception - thrown when user is not authenticated
class AuthenticationException extends AppException {
  const AuthenticationException({super.message = 'Authentication required'});
}

/// Not found exception - thrown when resource is not found
class NotFoundException extends AppException {
  const NotFoundException({super.message = 'Resource not found'});
}

/// Validation exception - thrown when input validation fails
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({required super.message, this.fieldErrors});
}
