import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/core/usecases/usecase.dart';
import 'package:taxi_client_app/domain/entities/category.dart';
import 'package:taxi_client_app/domain/repositories/category_repository.dart';

/// Use case to get product categories
class GetCategories implements UseCase<CategoriesList, GetCategoriesParams> {
  final CategoryRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, CategoriesList>> call(GetCategoriesParams params) async {
    return await repository.getCategories(limit: params.limit, offset: params.offset);
  }
}

/// Parameters for GetCategories use case
class GetCategoriesParams extends Equatable {
  final int limit;
  final int offset;

  const GetCategoriesParams({this.limit = 50, this.offset = 0});

  @override
  List<Object?> get props => [limit, offset];
}
