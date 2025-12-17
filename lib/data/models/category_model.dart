import 'package:taxi_client_app/domain/entities/category.dart';
import 'package:taxi_client_app/domain/entities/region.dart';

/// Product Category Model - extends ProductCategory entity with JSON serialization
class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel({
    required super.id,
    required super.name,
    super.description,
    required super.handle,
    super.rank = 0,
    super.parentCategoryId,
    super.metadata,
    super.parentCategory,
    super.categoryChildren = const [],
    required super.createdAt,
    super.updatedAt,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      handle: json['handle'] ?? '',
      rank: json['rank'] ?? 0,
      parentCategoryId: json['parent_category_id'],
      metadata: json['metadata'],
      parentCategory: json['parent_category'] != null
          ? ProductCategoryModel.fromJson(json['parent_category'])
          : null,
      categoryChildren: (json['category_children'] as List? ?? [])
          .map((c) => ProductCategoryModel.fromJson(c))
          .toList(),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'handle': handle,
      'rank': rank,
      'parent_category_id': parentCategoryId,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Convert to domain entity
  ProductCategory toEntity() => ProductCategory(
    id: id,
    name: name,
    description: description,
    handle: handle,
    rank: rank,
    parentCategoryId: parentCategoryId,
    metadata: metadata,
    parentCategory: parentCategory,
    categoryChildren: categoryChildren,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

/// Categories List Response Model
class CategoriesListModel {
  final List<ProductCategoryModel> categories;
  final int count;
  final int offset;
  final int limit;

  CategoriesListModel({
    required this.categories,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory CategoriesListModel.fromJson(Map<String, dynamic> json) {
    return CategoriesListModel(
      categories: (json['product_categories'] as List? ?? [])
          .map((c) => ProductCategoryModel.fromJson(c))
          .toList(),
      count: json['count'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 50,
    );
  }

  /// Convert to domain entity
  CategoriesList toEntity() => CategoriesList(
    categories: categories.map((c) => c.toEntity()).toList(),
    count: count,
    offset: offset,
    limit: limit,
  );
}

/// Region Model
class RegionModel extends Region {
  const RegionModel({
    required super.id,
    required super.name,
    required super.currencyCode,
    super.countries = const [],
    required super.createdAt,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      currencyCode: json['currency_code'] ?? '',
      countries: (json['countries'] as List? ?? []).map((c) => CountryModel.fromJson(c)).toList(),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }

  /// Convert to domain entity
  Region toEntity() =>
      Region(id: id, name: name, currencyCode: currencyCode, countries: countries, createdAt: createdAt);
}

/// Country Model
class CountryModel extends Country {
  const CountryModel({
    required super.iso2,
    required super.iso3,
    required super.name,
    required super.displayName,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      iso2: json['iso_2'] ?? '',
      iso3: json['iso_3'] ?? '',
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? '',
    );
  }

  /// Convert to domain entity
  Country toEntity() => Country(iso2: iso2, iso3: iso3, name: name, displayName: displayName);
}

/// Regions List Response Model
class RegionsListModel {
  final List<RegionModel> regions;
  final int count;
  final int offset;
  final int limit;

  RegionsListModel({required this.regions, required this.count, required this.offset, required this.limit});

  factory RegionsListModel.fromJson(Map<String, dynamic> json) {
    return RegionsListModel(
      regions: (json['regions'] as List? ?? []).map((r) => RegionModel.fromJson(r)).toList(),
      count: json['count'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 50,
    );
  }

  /// Convert to domain entity
  RegionsList toEntity() => RegionsList(
    regions: regions.map((r) => r.toEntity()).toList(),
    count: count,
    offset: offset,
    limit: limit,
  );
}
