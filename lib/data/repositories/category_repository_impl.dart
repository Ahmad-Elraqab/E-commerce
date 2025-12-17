import 'package:dartz/dartz.dart';
import 'package:taxi_client_app/core/error/exceptions.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/core/network/network_info.dart';
import 'package:taxi_client_app/data/datasources/remote/tuwatech_remote_datasource.dart';
import 'package:taxi_client_app/domain/entities/category.dart';
import 'package:taxi_client_app/domain/entities/region.dart';
import 'package:taxi_client_app/domain/repositories/category_repository.dart';

/// Category Repository Implementation
class CategoryRepositoryImpl implements CategoryRepository {
  final TuwaTechRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, CategoriesList>> getCategories({int limit = 50, int offset = 0}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getCategories(limit: limit, offset: offset);
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
  Future<Either<Failure, RegionsList>> getRegions({int limit = 50, int offset = 0}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getRegions(limit: limit, offset: offset);
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
