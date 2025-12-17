import 'package:dartz/dartz.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/domain/entities/category.dart';
import 'package:taxi_client_app/domain/entities/region.dart';

/// Abstract Category Repository - defines the contract for category operations
abstract class CategoryRepository {
  /// Get all product categories
  Future<Either<Failure, CategoriesList>> getCategories({int limit = 50, int offset = 0});

  /// Get all regions
  Future<Either<Failure, RegionsList>> getRegions({int limit = 50, int offset = 0});
}
