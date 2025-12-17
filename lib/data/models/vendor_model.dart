import 'package:taxi_client_app/domain/entities/vendor.dart';

/// Vendor Model - extends Vendor entity with JSON serialization
class VendorModel extends Vendor {
  const VendorModel({
    required super.id,
    required super.name,
    required super.handle,
    super.description,
    super.logo,
    super.email,
    super.phone,
    super.address,
    super.city,
    super.country,
    super.rating = 0.0,
    super.totalReviews = 0,
    super.isActive = true,
    super.commissionRate,
    super.metadata,
    required super.createdAt,
    super.updatedAt,
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

  /// Convert to domain entity
  Vendor toEntity() => Vendor(
    id: id,
    name: name,
    handle: handle,
    description: description,
    logo: logo,
    email: email,
    phone: phone,
    address: address,
    city: city,
    country: country,
    rating: rating,
    totalReviews: totalReviews,
    isActive: isActive,
    commissionRate: commissionRate,
    metadata: metadata,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

/// Vendors List Response Model
class VendorsListModel {
  final List<VendorModel> vendors;
  final int count;
  final int total;
  final int offset;
  final int limit;

  VendorsListModel({
    required this.vendors,
    required this.count,
    required this.total,
    required this.offset,
    required this.limit,
  });

  factory VendorsListModel.fromJson(Map<String, dynamic> json) {
    return VendorsListModel(
      vendors: (json['vendors'] as List? ?? []).map((v) => VendorModel.fromJson(v)).toList(),
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 20,
    );
  }

  /// Convert to domain entity
  VendorsList toEntity() => VendorsList(
    vendors: vendors.map((v) => v.toEntity()).toList(),
    count: count,
    total: total,
    offset: offset,
    limit: limit,
  );
}
