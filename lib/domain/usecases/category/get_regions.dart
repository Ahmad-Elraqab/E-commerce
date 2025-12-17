import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/core/usecases/usecase.dart';
import 'package:taxi_client_app/domain/entities/region.dart';
import 'package:taxi_client_app/domain/repositories/category_repository.dart';

/// Use case to get regions
class GetRegions implements UseCase<RegionsList, GetRegionsParams> {
  final CategoryRepository repository;

  GetRegions(this.repository);

  @override
  Future<Either<Failure, RegionsList>> call(GetRegionsParams params) async {
    return await repository.getRegions(limit: params.limit, offset: params.offset);
  }
}

/// Parameters for GetRegions use case
class GetRegionsParams extends Equatable {
  final int limit;
  final int offset;

  const GetRegionsParams({this.limit = 50, this.offset = 0});

  @override
  List<Object?> get props => [limit, offset];
}
