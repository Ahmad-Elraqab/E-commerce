import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Core
import 'package:taxi_client_app/core/network/network_info.dart';

// Data Sources
import 'package:taxi_client_app/data/datasources/remote/tuwatech_remote_datasource.dart';

// Repositories
import 'package:taxi_client_app/data/repositories/vendor_repository_impl.dart';
import 'package:taxi_client_app/data/repositories/category_repository_impl.dart';
import 'package:taxi_client_app/domain/repositories/vendor_repository.dart';
import 'package:taxi_client_app/domain/repositories/category_repository.dart';

// Use Cases - Vendor
import 'package:taxi_client_app/domain/usecases/vendor/get_vendors.dart';
import 'package:taxi_client_app/domain/usecases/vendor/get_vendor_by_handle.dart';
import 'package:taxi_client_app/domain/usecases/vendor/get_vendor_reviews.dart';

// Use Cases - Category
import 'package:taxi_client_app/domain/usecases/category/get_categories.dart';
import 'package:taxi_client_app/domain/usecases/category/get_regions.dart';

// Presentation
import 'package:taxi_client_app/presentation/view_models/vendors_view_model.dart';
import 'package:taxi_client_app/presentation/view_models/categories_view_model.dart';

/// Service Locator
final sl = GetIt.instance;

/// TuwaTech API Configuration
class TuwaTechApiConfig {
  static const String baseUrl = 'https://store.tuwatech.com';
  static const String publishableApiKey =
      'pk_214d189c949ed23880fa148ec2bfa01444fe779e4887467fd2418f4a1137a4ab';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 15000;
}

/// Initialize all dependencies
Future<void> init() async {
  //! Features - Vendors
  // View Models
  sl.registerFactory(
    () => VendorsViewModel(getVendors: sl(), getVendorByHandle: sl(), getVendorReviews: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetVendors(sl()));
  sl.registerLazySingleton(() => GetVendorByHandle(sl()));
  sl.registerLazySingleton(() => GetVendorReviews(sl()));

  // Repository
  sl.registerLazySingleton<VendorRepository>(
    () => VendorRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //! Features - Categories
  // View Models
  sl.registerFactory(() => CategoriesViewModel(getCategories: sl(), getRegions: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetRegions(sl()));

  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  // Dio
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: TuwaTechApiConfig.baseUrl,
        connectTimeout: TuwaTechApiConfig.connectTimeout,
        receiveTimeout: TuwaTechApiConfig.receiveTimeout,
        sendTimeout: TuwaTechApiConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-publishable-api-key': TuwaTechApiConfig.publishableApiKey,
        },
      ),
    );

    // Add logging interceptor for debugging
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));

    return dio;
  });

  // Connectivity
  sl.registerLazySingleton(() => Connectivity());

  //! Data Sources
  sl.registerLazySingleton<TuwaTechRemoteDataSource>(() => TuwaTechRemoteDataSourceImpl(dio: sl()));
}
