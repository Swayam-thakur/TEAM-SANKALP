import 'app_enums.dart';
import 'model_utils.dart';

class ReviewModel {
  const ReviewModel({
    required this.id,
    required this.bookingId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    required this.createdAt,
    required this.reviewerRole,
    this.comment,
  });

  final String id;
  final String bookingId;
  final String reviewerId;
  final String revieweeId;
  final double rating;
  final String? comment;
  final DateTime createdAt;
  final UserRole reviewerRole;

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookingId': bookingId,
        'reviewerId': reviewerId,
        'revieweeId': revieweeId,
        'rating': rating,
        'comment': comment,
        'createdAt': serializeDate(createdAt),
        'reviewerRole': reviewerRole.name,
      };

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String? ?? '',
      bookingId: json['bookingId'] as String? ?? '',
      reviewerId: json['reviewerId'] as String? ?? '',
      revieweeId: json['revieweeId'] as String? ?? '',
      rating: parseDouble(json['rating']),
      comment: json['comment'] as String?,
      createdAt: parseDate(json['createdAt']),
      reviewerRole: UserRole.values.firstWhere(
        (item) => item.name == json['reviewerRole'],
        orElse: () => UserRole.user,
      ),
    );
  }
}

