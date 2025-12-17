import 'package:dio/dio.dart';
import 'package:taxi_client_app/core/error/exceptions.dart';
import 'package:taxi_client_app/data/models/vendor_model.dart';
import 'package:taxi_client_app/data/models/review_model.dart';
import 'package:taxi_client_app/data/models/category_model.dart';

/// Abstract TuwaTech Remote Data Source
abstract class TuwaTechRemoteDataSource {
  /// Get all vendors
  Future<VendorsListModel> getVendors({
    int limit = 20,
    int offset = 0,
    String? country,
    String? city,
    String? searchQuery,
  });

  /// Get vendor by handle
  Future<VendorModel> getVendorByHandle(String handle);

  /// Get vendor reviews
  Future<ReviewsListModel> getVendorReviews(String handle, {int limit = 20, int offset = 0});

  /// Get product categories
  Future<CategoriesListModel> getCategories({int limit = 50, int offset = 0});

  /// Get regions
  Future<RegionsListModel> getRegions({int limit = 50, int offset = 0});

  /// Health check
  Future<bool> healthCheck();
}

/// TuwaTech Remote Data Source Implementation
class TuwaTechRemoteDataSourceImpl implements TuwaTechRemoteDataSource {
  final Dio dio;

  TuwaTechRemoteDataSourceImpl({required this.dio});

  @override
  Future<bool> healthCheck() async {
    try {
      final response = await dio.get('/health');
      return response.statusCode == 200 && response.data == 'OK';
    } catch (e) {
      return false;
    }
  }

  @override
  Future<VendorsListModel> getVendors({
    int limit = 20,
    int offset = 0,
    String? country,
    String? city,
    String? searchQuery,
  }) async {
    try {
      final queryParams = <String, dynamic>{'limit': limit, 'offset': offset};
      if (country != null) queryParams['country'] = country;
      if (city != null) queryParams['city'] = city;
      if (searchQuery != null && searchQuery.isNotEmpty) queryParams['q'] = searchQuery;

      final response = await dio.get('/store/vendors', queryParameters: queryParams);

      if (response.statusCode == 200) {
        return VendorsListModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to fetch vendors',
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<VendorModel> getVendorByHandle(String handle) async {
    try {
      final response = await dio.get('/store/vendors/$handle');

      if (response.statusCode == 200) {
        return VendorModel.fromJson(response.data['vendor']);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to fetch vendor',
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<ReviewsListModel> getVendorReviews(String handle, {int limit = 20, int offset = 0}) async {
    try {
      final response = await dio.get(
        '/store/vendors/$handle/reviews',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      if (response.statusCode == 200) {
        return ReviewsListModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to fetch reviews',
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<CategoriesListModel> getCategories({int limit = 50, int offset = 0}) async {
    try {
      final response = await dio.get(
        '/store/product-categories',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      if (response.statusCode == 200) {
        return CategoriesListModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to fetch categories',
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<RegionsListModel> getRegions({int limit = 50, int offset = 0}) async {
    try {
      final response = await dio.get('/store/regions', queryParameters: {'limit': limit, 'offset': offset});

      if (response.statusCode == 200) {
        return RegionsListModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Failed to fetch regions',
          statusCode: response.statusCode,
        );
      }
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  AppException _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return const NetworkException(message: 'Connection timeout');
      case DioErrorType.response:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'] ?? 'Server error';
        if (statusCode == 401) {
          return AuthenticationException(message: message);
        } else if (statusCode == 404) {
          return NotFoundException(message: message);
        }
        return ServerException(message: message, statusCode: statusCode);
      case DioErrorType.cancel:
        return const ServerException(message: 'Request cancelled');
      case DioErrorType.other:
        return const NetworkException(message: 'No internet connection');
      default:
        return ServerException(message: error.message ?? 'Unknown error');
    }
  }
}
