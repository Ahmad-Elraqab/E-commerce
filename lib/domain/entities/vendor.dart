import 'package:equatable/equatable.dart';

/// Vendor entity - represents a vendor in the domain layer
class Vendor extends Equatable {
  final String id;
  final String name;
  final String handle;
  final String? description;
  final String? logo;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final String? country;
  final double rating;
  final int totalReviews;
  final bool isActive;
  final int? commissionRate;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Vendor({
    required this.id,
    required this.name,
    required this.handle,
    this.description,
    this.logo,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.isActive = true,
    this.commissionRate,
    this.metadata,
    required this.createdAt,
    this.updatedAt,
  });

  /// Get specialties from metadata
  List<String> get specialties {
    if (metadata != null && metadata!['specialties'] != null) {
      return List<String>.from(metadata!['specialties']);
    }
    return [];
  }

  /// Get founded year from metadata
  int? get foundedYear {
    if (metadata != null && metadata!['founded_year'] != null) {
      return metadata!['founded_year'] as int;
    }
    return null;
  }

  /// Get employee count from metadata
  String? get employeeCount {
    if (metadata != null && metadata!['employees'] != null) {
      return metadata!['employees'] as String;
    }
    return null;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    handle,
    description,
    logo,
    email,
    phone,
    address,
    city,
    country,
    rating,
    totalReviews,
    isActive,
    commissionRate,
    metadata,
    createdAt,
    updatedAt,
  ];
}

/// Vendors list with pagination info
class VendorsList extends Equatable {
  final List<Vendor> vendors;
  final int count;
  final int total;
  final int offset;
  final int limit;

  const VendorsList({
    required this.vendors,
    required this.count,
    required this.total,
    required this.offset,
    required this.limit,
  });

  @override
  List<Object?> get props => [vendors, count, total, offset, limit];
}
