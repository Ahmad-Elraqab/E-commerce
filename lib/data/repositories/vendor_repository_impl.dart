import 'package:dartz/dartz.dart';
import 'package:taxi_client_app/core/error/exceptions.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/core/network/network_info.dart';
import 'package:taxi_client_app/data/datasources/remote/tuwatech_remote_datasource.dart';
import 'package:taxi_client_app/domain/entities/vendor.dart';
import 'package:taxi_client_app/domain/entities/review.dart';
import 'package:taxi_client_app/domain/repositories/vendor_repository.dart';

/// Vendor Repository Implementation
class VendorRepositoryImpl implements VendorRepository {
  final TuwaTechRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  VendorRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, VendorsList>> getVendors({
    int limit = 20,
    int offset = 0,
    String? country,
    String? city,
    String? searchQuery,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getVendors(
          limit: limit,
          offset: offset,
          country: country,
          city: city,
          searchQuery: searchQuery,
        );
        return Right(result.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Vendor>> getVendorByHandle(String handle) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getVendorByHandle(handle);
        return Right(result.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ReviewsList>> getVendorReviews(
    String handle, {
    int limit = 20,
    int offset = 0,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getVendorReviews(handle, limit: limit, offset: offset);
        return Right(result.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
