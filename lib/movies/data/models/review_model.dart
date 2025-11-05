import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/movies/domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.authorName,
    required super.authorUserName,
    required super.avatarUrl,
    required super.rating,
    required super.content,
    required super.elapsedTime,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
  final authorDetails = json['author_details'] ?? {};

  return ReviewModel(
    authorName: json['author'] ?? "",
    authorUserName: authorDetails['username'] != null
        ? '@${authorDetails['username']}'
        : "",
    avatarUrl: getAvatarUrl(authorDetails['avatar_path']),
    rating: authorDetails['rating'] != null
        ? (authorDetails['rating'] / 2)
        : 0.0,
    content: json['content'] ?? "",
    elapsedTime:json['created_at']!=null? getElapsedTime(json['created_at']??""):"",
  );
}
}
