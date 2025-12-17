/// Product Category Model for TuwaTech Store API
class ProductCategoryModel {
  final String id;
  final String name;
  final String? description;
  final String handle;
  final int rank;
  final String? parentCategoryId;
  final Map<String, dynamic>? metadata;
  final ProductCategoryModel? parentCategory;
  final List<ProductCategoryModel> categoryChildren;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProductCategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.handle,
    this.rank = 0,
    this.parentCategoryId,
    this.metadata,
    this.parentCategory,
    this.categoryChildren = const [],
    required this.createdAt,
    this.updatedAt,
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

  /// Get icon from metadata
  String? get icon {
    if (metadata != null && metadata!['icon'] != null) {
      return metadata!['icon'] as String;
    }
    return null;
  }

  /// Get color from metadata
  String? get color {
    if (metadata != null && metadata!['color'] != null) {
      return metadata!['color'] as String;
    }
    return null;
  }

  /// Get image URL from metadata
  String? get imageUrl {
    if (metadata != null && metadata!['image'] != null) {
      return metadata!['image'] as String;
    }
    return null;
  }

  /// Get description from metadata (some categories have it in metadata)
  String? get metadataDescription {
    if (metadata != null && metadata!['description'] != null) {
      return metadata!['description'] as String;
    }
    return description;
  }
}

/// Product Categories Response Model
class ProductCategoriesResponse {
  final List<ProductCategoryModel> categories;
  final int count;
  final int offset;
  final int limit;

  ProductCategoriesResponse({
    required this.categories,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory ProductCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return ProductCategoriesResponse(
      categories: (json['product_categories'] as List? ?? [])
          .map((c) => ProductCategoryModel.fromJson(c))
          .toList(),
      count: json['count'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 50,
    );
  }
}

/// Region Model
class RegionModel {
  final String id;
  final String name;
  final String currencyCode;
  final List<CountryModel> countries;
  final DateTime createdAt;

  RegionModel({
    required this.id,
    required this.name,
    required this.currencyCode,
    this.countries = const [],
    required this.createdAt,
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
}

/// Country Model
class CountryModel {
  final String iso2;
  final String iso3;
  final String name;
  final String displayName;

  CountryModel({required this.iso2, required this.iso3, required this.name, required this.displayName});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      iso2: json['iso_2'] ?? '',
      iso3: json['iso_3'] ?? '',
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? '',
    );
  }
}

/// Regions Response Model
class RegionsResponse {
  final List<RegionModel> regions;
  final int count;
  final int offset;
  final int limit;

  RegionsResponse({required this.regions, required this.count, required this.offset, required this.limit});

  factory RegionsResponse.fromJson(Map<String, dynamic> json) {
    return RegionsResponse(
      regions: (json['regions'] as List? ?? []).map((r) => RegionModel.fromJson(r)).toList(),
      count: json['count'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 50,
    );
  }
}
