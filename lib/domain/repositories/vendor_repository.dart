import 'package:dartz/dartz.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/domain/entities/vendor.dart';
import 'package:taxi_client_app/domain/entities/review.dart';

/// Abstract Vendor Repository - defines the contract for vendor operations
abstract class VendorRepository {
  /// Get all vendors with optional filtering
  Future<Either<Failure, VendorsList>> getVendors({
    int limit = 20,
    int offset = 0,
    String? country,
    String? city,
    String? searchQuery,
  });

  /// Get a single vendor by handle
  Future<Either<Failure, Vendor>> getVendorByHandle(String handle);

  /// Get vendor reviews
  Future<Either<Failure, ReviewsList>> getVendorReviews(String handle, {int limit = 20, int offset = 0});
}
