import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_client_app/core/error/failures.dart';
import 'package:taxi_client_app/core/usecases/usecase.dart';
import 'package:taxi_client_app/domain/entities/vendor.dart';
import 'package:taxi_client_app/domain/repositories/vendor_repository.dart';

/// Use case to get a vendor by handle
class GetVendorByHandle implements UseCase<Vendor, GetVendorByHandleParams> {
  final VendorRepository repository;

  GetVendorByHandle(this.repository);

  @override
  Future<Either<Failure, Vendor>> call(GetVendorByHandleParams params) async {
    return await repository.getVendorByHandle(params.handle);
  }
}

/// Parameters for GetVendorByHandle use case
class GetVendorByHandleParams extends Equatable {
  final String handle;

  const GetVendorByHandleParams({required this.handle});

  @override
  List<Object?> get props => [handle];
}
