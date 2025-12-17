/// TuwaTech Store API Configuration
/// This file contains the configuration for connecting to the TuwaTech Store API
class TuwaTechConfig {
  TuwaTechConfig._();

  /// Base URL for the TuwaTech Store API
  static const String baseUrl = 'https://store.tuwatech.com';

  /// Publishable API Key for Store API access
  /// Required for all /store/* endpoints
  static const String publishableApiKey =
      'pk_214d189c949ed23880fa148ec2bfa01444fe779e4887467fd2418f4a1137a4ab';

  /// API Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 15000; // 15 seconds

  /// API Headers for Store endpoints
  static Map<String, String> get storeHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'x-publishable-api-key': publishableApiKey,
  };

  /// API Endpoints
  static const String healthEndpoint = '/health';
  static const String vendorsEndpoint = '/store/vendors';
  static String vendorByHandleEndpoint(String handle) => '/store/vendors/$handle';
  static String vendorProductsEndpoint(String handle) => '/store/vendors/$handle/products';
  static String vendorReviewsEndpoint(String handle) => '/store/vendors/$handle/reviews';

  // Product & Category Endpoints
  static const String productCategoriesEndpoint = '/store/product-categories';
  static const String regionsEndpoint = '/store/regions';
  static const String collectionsEndpoint = '/store/collections';
  static const String productsEndpoint = '/store/products';
}
