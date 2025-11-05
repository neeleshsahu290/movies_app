import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/utils/functions.dart';

class MovieModel extends Media {
  const MovieModel({
    required super.tmdbID,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.voteAverage,
    required super.releaseDate,
    required super.overview,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    tmdbID: json['id'],
    title: json['title'],
    posterUrl: getPosterUrl(json['poster_path']),
    backdropUrl: getBackdropUrl(json['backdrop_path']),
    voteAverage: double.parse((json['vote_average']).toStringAsFixed(1)),
    releaseDate: getDate(json['release_date']),
    overview: json['overview'] ?? '',
  );
}

class MovieResponse {
  final List<MovieModel> results;

  MovieResponse({required this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    results: (json['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList(),
  );
}
