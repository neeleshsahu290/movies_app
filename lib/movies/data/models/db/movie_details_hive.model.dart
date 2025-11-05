import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';

import 'movie_hive_model.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/movies/data/models/cast_model.dart';
import 'package:movies_app/movies/data/models/review_model.dart';

part 'movie_details_hive.model.g.dart';

@HiveType(typeId: 2)
class MovieDetailsHiveModel {
  @HiveField(0)
  int tmdbID;

  @HiveField(1)
  String title;

  @HiveField(2)
  String posterUrl;

  @HiveField(3)
  String backdropUrl;

  @HiveField(4)
  String releaseDate;

  @HiveField(5)
  String genres;

  @HiveField(6)
  String? runtime;

  @HiveField(7)
  String overview;

  @HiveField(8)
  double voteAverage;

  @HiveField(9)
  String voteCount;

  @HiveField(10)
  String trailerUrl;

  @HiveField(11)
  List<MovieHiveModel> similar;

  @HiveField(12)
  String castJson;

  @HiveField(13)
  String reviewsJson;

  @HiveField(14)
  bool isBookmarked;

  MovieDetailsHiveModel({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.genres,
    this.runtime,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.trailerUrl,
    required this.similar,
    required this.castJson,
    required this.reviewsJson,
    this.isBookmarked = false,
  });

  factory MovieDetailsHiveModel.fromMovieDetails(MediaDetails m) {
    return MovieDetailsHiveModel(
      tmdbID: m.tmdbID,
      title: m.title,
      posterUrl: m.posterUrl,
      backdropUrl: m.backdropUrl,
      releaseDate: m.releaseDate,
      genres: m.genres,
      runtime: m.runtime,
      overview: m.overview,
      voteAverage: m.voteAverage,
      voteCount: m.voteCount,
      trailerUrl: m.trailerUrl,
      similar: m.similar
          .map(
            (media) =>
                MovieHiveModel.fromMovieModel(media as dynamic, "similar"),
          )
          .toList(),
      castJson: jsonEncode(
        List<Map<String, dynamic>>.from(
          (m.cast ?? []).map((e) => (e as CastModel).toJson()),
        ),
      ),
      reviewsJson: jsonEncode(
        List<Map<String, dynamic>>.from(
          (m.reviews ?? []).map((e) => (e as ReviewModel).toJson()),
        ),
      ),
      isBookmarked: m.isBookmarked,
    );
  }

   MovieDetailsModel toMovieDetailsModel() {
    return MovieDetailsModel(
      tmdbID: tmdbID,
      title: title,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      releaseDate: releaseDate,
      genres: genres, // if you stored genres as "Action,Comedy"
      runtime: runtime,          // adjust type if your domain expects int/String
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      trailerUrl: trailerUrl,
      cast: castJson.isEmpty
          ? []
          : List<CastModel>.from(
              (jsonDecode(castJson) as List).map(
                (e) => CastModel.fromJson(e),
              ),
            ),
      reviews: reviewsJson.isEmpty
          ? []
          : List<ReviewModel>.from(
              (jsonDecode(reviewsJson) as List).map(
                (e) => ReviewModel.fromJson(e),
              ),
            ),
      similar: similar.map((e) => e.toMovieModel()).toList(),
    );
  }
}
