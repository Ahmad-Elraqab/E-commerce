/// Vendor Model for TuwaTech Store API
class VendorModel {
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

  VendorModel({
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

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      handle: json['handle'] ?? '',
      description: json['description'],
      logo: json['logo'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      rating: (json['rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      isActive: json['is_active'] ?? true,
      commissionRate: json['commission_rate'],
      metadata: json['metadata'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'handle': handle,
      'description': description,
      'logo': logo,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'country': country,
      'rating': rating,
      'total_reviews': totalReviews,
      'is_active': isActive,
      'commission_rate': commissionRate,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

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
}

/// Vendors Response Model
class VendorsResponse {
  final List<VendorModel> vendors;
  final int count;
  final int total;
  final int offset;
  final int limit;

  VendorsResponse({
    required this.vendors,
    required this.count,
    required this.total,
    required this.offset,
    required this.limit,
  });

  factory VendorsResponse.fromJson(Map<String, dynamic> json) {
    return VendorsResponse(
      vendors: (json['vendors'] as List? ?? []).map((v) => VendorModel.fromJson(v)).toList(),
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 20,
    );
  }
}
