import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/core/usecases/usecase.dart';
import 'package:taxi_client_app/domain/entities/vendor.dart';
import 'package:taxi_client_app/domain/repositories/vendor_repository.dart';

/// Use case to get list of vendors
class GetVendors implements UseCase<VendorsList, GetVendorsParams> {
  final VendorRepository repository;

  GetVendors(this.repository);

  @override
  Future<Either<Failure, VendorsList>> call(GetVendorsParams params) async {
    return await repository.getVendors(
      limit: params.limit,
      offset: params.offset,
      country: params.country,
      city: params.city,
      searchQuery: params.searchQuery,
    );
  }
}

/// Parameters for GetVendors use case
class GetVendorsParams extends Equatable {
  final int limit;
  final int offset;
  final String? country;
  final String? city;
  final String? searchQuery;

  const GetVendorsParams({this.limit = 20, this.offset = 0, this.country, this.city, this.searchQuery});

  @override
  List<Object?> get props => [limit, offset, country, city, searchQuery];
}
