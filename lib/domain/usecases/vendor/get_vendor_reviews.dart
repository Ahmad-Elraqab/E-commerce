import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/core/usecases/usecase.dart';
import 'package:taxi_client_app/domain/entities/review.dart';
import 'package:taxi_client_app/domain/repositories/vendor_repository.dart';

/// Use case to get vendor reviews
class GetVendorReviews implements UseCase<ReviewsList, GetVendorReviewsParams> {
  final VendorRepository repository;

  GetVendorReviews(this.repository);

  @override
  Future<Either<Failure, ReviewsList>> call(GetVendorReviewsParams params) async {
    return await repository.getVendorReviews(params.handle, limit: params.limit, offset: params.offset);
  }
}

/// Parameters for GetVendorReviews use case
class GetVendorReviewsParams extends Equatable {
  final String handle;
  final int limit;
  final int offset;

  const GetVendorReviewsParams({required this.handle, this.limit = 20, this.offset = 0});

  @override
  List<Object?> get props => [handle, limit, offset];
}
