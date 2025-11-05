import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String? authorName;
  final String? authorUserName;
  final String? avatarUrl;
  final double? rating;
  final String? content;
  final String? elapsedTime;

  const Review({
    this.authorName,
    this.authorUserName,
    this.avatarUrl,
    this.rating,
    this.content,
    this.elapsedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "authorName": authorName ?? "",
      "authorUserName": authorUserName ?? "",
      "avatarUrl": avatarUrl ?? "",
      "rating": rating ?? 0.0,
      "content": content ?? "",
      "elapsedTime": elapsedTime ?? "",
    };
  }

  @override
  List<Object?> get props => [
        authorName,
        authorUserName,
        avatarUrl,
        rating,
        content,
        elapsedTime,
      ];
}