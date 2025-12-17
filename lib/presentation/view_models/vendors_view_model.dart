import 'package:flutter/foundation.dart';
import 'package:taxi_client_app/domain/entities/vendor.dart';
import 'package:taxi_client_app/domain/entities/review.dart';
import 'package:taxi_client_app/domain/usecases/vendor/get_vendors.dart';
import 'package:taxi_client_app/domain/usecases/vendor/get_vendor_by_handle.dart';
import 'package:taxi_client_app/domain/usecases/vendor/get_vendor_reviews.dart';

/// View Model State
enum ViewState { initial, loading, loaded, error }

/// Vendors View Model - manages vendors data and state
class VendorsViewModel extends ChangeNotifier {
  final GetVendors getVendors;
  final GetVendorByHandle getVendorByHandle;
  final GetVendorReviews getVendorReviews;

  VendorsViewModel({
    required this.getVendors,
    required this.getVendorByHandle,
    required this.getVendorReviews,
  });

  // State
  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  // Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Vendors list
  List<Vendor> _vendors = [];
  List<Vendor> get vendors => _vendors;

  // Current vendor
  Vendor? _currentVendor;
  Vendor? get currentVendor => _currentVendor;

  // Current vendor reviews
  List<Review> _reviews = [];
  List<Review> get reviews => _reviews;

  // Reviews summary
  double _averageRating = 0.0;
  double get averageRating => _averageRating;

  int _totalReviews = 0;
  int get totalReviews => _totalReviews;

  // Pagination
  int _offset = 0;
  int _total = 0;
  bool get hasMore => _vendors.length < _total;

  /// Fetch vendors list
  Future<void> fetchVendors({
    int limit = 20,
    bool refresh = false,
    String? country,
    String? city,
    String? searchQuery,
  }) async {
    if (refresh) {
      _offset = 0;
      _vendors = [];
    }

    _state = _vendors.isEmpty ? ViewState.loading : _state;
    _errorMessage = null;
    notifyListeners();

    final result = await getVendors(
      GetVendorsParams(limit: limit, offset: _offset, country: country, city: city, searchQuery: searchQuery),
    );

    result.fold(
      (failure) {
        _state = ViewState.error;
        _errorMessage = failure.message;
      },
      (vendorsList) {
        _vendors = refresh ? vendorsList.vendors : [..._vendors, ...vendorsList.vendors];
        _total = vendorsList.total;
        _offset += vendorsList.count;
        _state = ViewState.loaded;
      },
    );

    notifyListeners();
  }

  /// Fetch vendor details by handle
  Future<void> fetchVendorDetails(String handle) async {
    _state = ViewState.loading;
    _errorMessage = null;
    _currentVendor = null;
    _reviews = [];
    notifyListeners();

    // Fetch vendor and reviews in parallel
    final vendorResult = await getVendorByHandle(GetVendorByHandleParams(handle: handle));
    final reviewsResult = await getVendorReviews(GetVendorReviewsParams(handle: handle, limit: 10));

    vendorResult.fold(
      (failure) {
        _state = ViewState.error;
        _errorMessage = failure.message;
      },
      (vendor) {
        _currentVendor = vendor;
        _state = ViewState.loaded;
      },
    );

    reviewsResult.fold(
      (failure) {
        // Don't fail the whole request if reviews fail
        _reviews = [];
      },
      (reviewsList) {
        _reviews = reviewsList.reviews;
        _averageRating = reviewsList.averageRating;
        _totalReviews = reviewsList.totalReviews;
      },
    );

    notifyListeners();
  }

  /// Reset state
  void reset() {
    _state = ViewState.initial;
    _errorMessage = null;
    _vendors = [];
    _currentVendor = null;
    _reviews = [];
    _offset = 0;
    _total = 0;
    notifyListeners();
  }
}
