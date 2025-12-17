import 'package:taxi_client_app/domain/entities/review.dart';

/// Review Model - extends Review entity with JSON serialization
class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.rating,
    super.title,
    super.content,
    super.isVerified = false,
    required super.createdAt,
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

  /// Convert to domain entity
  Review toEntity() => Review(
    id: id,
    rating: rating,
    title: title,
    content: content,
    isVerified: isVerified,
    createdAt: createdAt,
  );
}

/// Rating Distribution Model
class RatingDistributionModel extends RatingDistribution {
  const RatingDistributionModel({
    super.oneStar = 0,
    super.twoStar = 0,
    super.threeStar = 0,
    super.fourStar = 0,
    super.fiveStar = 0,
  });

  factory RatingDistributionModel.fromJson(Map<String, dynamic> json) {
    return RatingDistributionModel(
      oneStar: json['1'] ?? 0,
      twoStar: json['2'] ?? 0,
      threeStar: json['3'] ?? 0,
      fourStar: json['4'] ?? 0,
      fiveStar: json['5'] ?? 0,
    );
  }

  /// Convert to domain entity
  RatingDistribution toEntity() => RatingDistribution(
    oneStar: oneStar,
    twoStar: twoStar,
    threeStar: threeStar,
    fourStar: fourStar,
    fiveStar: fiveStar,
  );
}

/// Reviews List Response Model
class ReviewsListModel {
  final List<ReviewModel> reviews;
  final int count;
  final int total;
  final int offset;
  final int limit;
  final double averageRating;
  final int totalReviews;
  final RatingDistributionModel? ratingDistribution;

  ReviewsListModel({
    required this.reviews,
    required this.count,
    required this.total,
    required this.offset,
    required this.limit,
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.ratingDistribution,
  });

  factory ReviewsListModel.fromJson(Map<String, dynamic> json) {
    return ReviewsListModel(
      reviews: (json['reviews'] as List? ?? []).map((r) => ReviewModel.fromJson(r)).toList(),
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 20,
      averageRating: (json['summary']?['average_rating'] ?? 0).toDouble(),
      totalReviews: json['summary']?['total_reviews'] ?? 0,
      ratingDistribution: json['summary']?['rating_distribution'] != null
          ? RatingDistributionModel.fromJson(json['summary']['rating_distribution'])
          : null,
    );
  }

  /// Convert to domain entity
  ReviewsList toEntity() => ReviewsList(
    reviews: reviews.map((r) => r.toEntity()).toList(),
    count: count,
    total: total,
    offset: offset,
    limit: limit,
    averageRating: averageRating,
    totalReviews: totalReviews,
    ratingDistribution: ratingDistribution?.toEntity(),
  );
}
