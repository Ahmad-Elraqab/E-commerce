import 'package:equatable/equatable.dart';

/// Product Category entity - represents a category in the domain layer
class ProductCategory extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String handle;
  final int rank;
  final String? parentCategoryId;
  final Map<String, dynamic>? metadata;
  final ProductCategory? parentCategory;
  final List<ProductCategory> categoryChildren;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProductCategory({
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

  /// Get description from metadata
  String? get metadataDescription {
    if (metadata != null && metadata!['description'] != null) {
      return metadata!['description'] as String;
    }
    return description;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    handle,
    rank,
    parentCategoryId,
    metadata,
    parentCategory,
    categoryChildren,
    createdAt,
    updatedAt,
  ];
}

/// Categories list with pagination info
class CategoriesList extends Equatable {
  final List<ProductCategory> categories;
  final int count;
  final int offset;
  final int limit;

  const CategoriesList({
    required this.categories,
    required this.count,
    required this.offset,
    required this.limit,
  });

  @override
  List<Object?> get props => [categories, count, offset, limit];
}
