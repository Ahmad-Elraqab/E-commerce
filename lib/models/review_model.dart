/// Review Model for TuwaTech Store API
class ReviewModel {
  final String id;
  final int rating;
  final String? title;
  final String? content;
  final bool isVerified;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.rating,
    this.title,
    this.content,
    this.isVerified = false,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      rating: json['rating'] ?? 0,
      title: json['title'],
      content: json['content'],
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'title': title,
      'content': content,
      'is_verified': isVerified,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

/// Rating Distribution Model
class RatingDistribution {
  final int oneStar;
  final int twoStar;
  final int threeStar;
  final int fourStar;
  final int fiveStar;

  RatingDistribution({
    this.oneStar = 0,
    this.twoStar = 0,
    this.threeStar = 0,
    this.fourStar = 0,
    this.fiveStar = 0,
  });

  factory RatingDistribution.fromJson(Map<String, dynamic> json) {
    return RatingDistribution(
      oneStar: json['1'] ?? 0,
      twoStar: json['2'] ?? 0,
      threeStar: json['3'] ?? 0,
      fourStar: json['4'] ?? 0,
      fiveStar: json['5'] ?? 0,
    );
  }

  int get total => oneStar + twoStar + threeStar + fourStar + fiveStar;
}

/// Reviews Response Model
class ReviewsResponse {
  final List<ReviewModel> reviews;
  final int count;
  final int total;
  final int offset;
  final int limit;
  final double averageRating;
  final int totalReviews;
  final RatingDistribution? ratingDistribution;
  final VendorInfo? vendor;

  ReviewsResponse({
    required this.reviews,
    required this.count,
    required this.total,
    required this.offset,
    required this.limit,
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.ratingDistribution,
    this.vendor,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    return ReviewsResponse(
      reviews: (json['reviews'] as List? ?? []).map((r) => ReviewModel.fromJson(r)).toList(),
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 20,
      averageRating: (json['summary']?['average_rating'] ?? 0).toDouble(),
      totalReviews: json['summary']?['total_reviews'] ?? 0,
      ratingDistribution: json['summary']?['rating_distribution'] != null
          ? RatingDistribution.fromJson(json['summary']['rating_distribution'])
          : null,
      vendor: json['vendor'] != null ? VendorInfo.fromJson(json['vendor']) : null,
    );
  }
}

/// Simple Vendor Info (for reviews response)
class VendorInfo {
  final String id;
  final String name;
  final String handle;

  VendorInfo({required this.id, required this.name, required this.handle});

  factory VendorInfo.fromJson(Map<String, dynamic> json) {
    return VendorInfo(id: json['id'] ?? '', name: json['name'] ?? '', handle: json['handle'] ?? '');
  }
}
