import 'package:dartz/dartz.dart';
import 'package:taxi_client_app/core/error/failures.dart';

/// Base class for all use cases
/// [Type] is the return type of the use case
/// [Params] is the parameters needed by the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use this class when the use case doesn't require any parameters
class NoParams {
  const NoParams();
}

/// Base class for paginated use case parameters
class PaginationParams {
  final int limit;
  final int offset;

  const PaginationParams({this.limit = 20, this.offset = 0});
}
