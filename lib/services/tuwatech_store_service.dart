import 'package:dio/dio.dart';
import 'package:taxi_client_app/app/config/tuwatech_config.dart';
import 'package:taxi_client_app/models/vendor_model.dart';
import 'package:taxi_client_app/models/review_model.dart';
import 'package:taxi_client_app/models/category_model.dart';

/// TuwaTech Store API Service
/// Handles all API calls to the TuwaTech Store backend
class TuwaTechStoreService {
  static final TuwaTechStoreService _instance = TuwaTechStoreService._internal();
  factory TuwaTechStoreService() => _instance;
  TuwaTechStoreService._internal();

  late final Dio _dio;
  bool _isInitialized = false;

  /// Initialize the service with Dio client
  void init() {
    if (_isInitialized) return;

    _dio = Dio(
      BaseOptions(
        baseUrl: TuwaTechConfig.baseUrl,
        connectTimeout: TuwaTechConfig.connectTimeout,
        receiveTimeout: TuwaTechConfig.receiveTimeout,
        sendTimeout: TuwaTechConfig.sendTimeout,
        headers: TuwaTechConfig.storeHeaders,
      ),
    );

    // Add logging interceptor for debugging
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));

    _isInitialized = true;
  }

  /// Health check - verify API is running
  Future<bool> healthCheck() async {
    try {
      final response = await _dio.get(TuwaTechConfig.healthEndpoint);
      return response.statusCode == 200 && response.data == 'OK';
    } catch (e) {
      print('Health check failed: $e');
      return false;
    }
  }

  /// Get all vendors with optional filtering
  Future<VendorsResponse> getVendors({
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
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['q'] = searchQuery;
      }

      final response = await _dio.get(TuwaTechConfig.vendorsEndpoint, queryParameters: queryParams);

      return VendorsResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching vendors: $e');
      rethrow;
    }
  }

  /// Get a single vendor by handle
  Future<VendorModel> getVendorByHandle(String handle) async {
    try {
      final response = await _dio.get(TuwaTechConfig.vendorByHandleEndpoint(handle));

      return VendorModel.fromJson(response.data['vendor']);
    } catch (e) {
      print('Error fetching vendor $handle: $e');
      rethrow;
    }
  }

  /// Get vendor reviews
  Future<ReviewsResponse> getVendorReviews(String handle, {int limit = 20, int offset = 0}) async {
    try {
      final response = await _dio.get(
        TuwaTechConfig.vendorReviewsEndpoint(handle),
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return ReviewsResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching reviews for $handle: $e');
      rethrow;
    }
  }

  /// Get vendor products (Note: Currently returns 500 error from API)
  Future<Map<String, dynamic>> getVendorProducts(String handle, {int limit = 20, int offset = 0}) async {
    try {
      final response = await _dio.get(
        TuwaTechConfig.vendorProductsEndpoint(handle),
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return response.data;
    } catch (e) {
      print('Error fetching products for $handle: $e');
      rethrow;
    }
  }

  /// Get all product categories
  Future<ProductCategoriesResponse> getProductCategories({int limit = 50, int offset = 0}) async {
    try {
      final response = await _dio.get(
        TuwaTechConfig.productCategoriesEndpoint,
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return ProductCategoriesResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching product categories: $e');
      rethrow;
    }
  }

  /// Get all regions
  Future<RegionsResponse> getRegions({int limit = 50, int offset = 0}) async {
    try {
      final response = await _dio.get(
        TuwaTechConfig.regionsEndpoint,
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return RegionsResponse.fromJson(response.data);
    } catch (e) {
      print('Error fetching regions: $e');
      rethrow;
    }
  }

  /// Get products (Note: Requires sales channel configuration on API key)
  /// Currently returns error: "Publishable key needs to have a sales channel configured"
  Future<Map<String, dynamic>> getProducts({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    String? regionId,
  }) async {
    try {
      final queryParams = <String, dynamic>{'limit': limit, 'offset': offset};
      if (categoryId != null) queryParams['category_id'] = categoryId;
      if (regionId != null) queryParams['region_id'] = regionId;

      final response = await _dio.get(TuwaTechConfig.productsEndpoint, queryParameters: queryParams);

      return response.data;
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }
}

/// Singleton instance for easy access
final tuwaTechStoreService = TuwaTechStoreService();
