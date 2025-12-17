import 'package:equatable/equatable.dart';

/// Review entity - represents a review in the domain layer
class Review extends Equatable {
  final String id;
  final int rating;
  final String? title;
  final String? content;
  final bool isVerified;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.rating,
    this.title,
    this.content,
    this.isVerified = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, rating, title, content, isVerified, createdAt];
}

/// Rating distribution
class RatingDistribution extends Equatable {
  final int oneStar;
  final int twoStar;
  final int threeStar;
  final int fourStar;
  final int fiveStar;

  const RatingDistribution({
    this.oneStar = 0,
    this.twoStar = 0,
    this.threeStar = 0,
    this.fourStar = 0,
    this.fiveStar = 0,
  });

  int get total => oneStar + twoStar + threeStar + fourStar + fiveStar;

  @override
  List<Object?> get props => [oneStar, twoStar, threeStar, fourStar, fiveStar];
}

/// Reviews list with pagination and summary
class ReviewsList extends Equatable {
  final List<Review> reviews;
  final int count;
  final int total;
  final int offset;
  final int limit;
  final double averageRating;
  final int totalReviews;
  final RatingDistribution? ratingDistribution;

  const ReviewsList({
    required this.reviews,
    required this.count,
    required this.total,
    required this.offset,
    required this.limit,
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.ratingDistribution,
  });

  @override
  List<Object?> get props => [
    reviews,
    count,
    total,
    offset,
    limit,
    averageRating,
    totalReviews,
    ratingDistribution,
  ];
}
