import 'package:flutter/foundation.dart';
import 'package:taxi_client_app/domain/entities/category.dart';
import 'package:taxi_client_app/domain/entities/region.dart';
import 'package:taxi_client_app/domain/usecases/category/get_categories.dart';
import 'package:taxi_client_app/domain/usecases/category/get_regions.dart';

/// View Model State
enum CategoriesViewState { initial, loading, loaded, error }

/// Categories View Model - manages categories data and state
class CategoriesViewModel extends ChangeNotifier {
  final GetCategories getCategories;
  final GetRegions getRegions;

  CategoriesViewModel({required this.getCategories, required this.getRegions});

  // State
  CategoriesViewState _state = CategoriesViewState.initial;
  CategoriesViewState get state => _state;

  // Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Categories list
  List<ProductCategory> _categories = [];
  List<ProductCategory> get categories => _categories;

  // Regions list
  List<Region> _regions = [];
  List<Region> get regions => _regions;

  // Loading states
  bool _isLoadingCategories = false;
  bool get isLoadingCategories => _isLoadingCategories;

  bool _isLoadingRegions = false;
  bool get isLoadingRegions => _isLoadingRegions;

  /// Fetch categories
  Future<void> fetchCategories({int limit = 50, int offset = 0}) async {
    _isLoadingCategories = true;
    _state = _categories.isEmpty ? CategoriesViewState.loading : _state;
    _errorMessage = null;
    notifyListeners();

    final result = await getCategories(GetCategoriesParams(limit: limit, offset: offset));

    result.fold(
      (failure) {
        _state = CategoriesViewState.error;
        _errorMessage = failure.message;
      },
      (categoriesList) {
        _categories = categoriesList.categories;
        _state = CategoriesViewState.loaded;
      },
    );

    _isLoadingCategories = false;
    notifyListeners();
  }

  /// Fetch regions
  Future<void> fetchRegions({int limit = 50, int offset = 0}) async {
    _isLoadingRegions = true;
    notifyListeners();

    final result = await getRegions(GetRegionsParams(limit: limit, offset: offset));

    result.fold(
      (failure) {
        // Don't fail the whole request if regions fail
        _regions = [];
      },
      (regionsList) {
        _regions = regionsList.regions;
      },
    );

    _isLoadingRegions = false;
    notifyListeners();
  }

  /// Fetch all data
  Future<void> fetchAll() async {
    await Future.wait([fetchCategories(), fetchRegions()]);
  }

  /// Reset state
  void reset() {
    _state = CategoriesViewState.initial;
    _errorMessage = null;
    _categories = [];
    _regions = [];
    notifyListeners();
  }
}
