import 'package:hive/hive.dart';
import '../movie_model.dart';

part 'movie_hive_model.g.dart';

@HiveType(typeId: 0)
class MovieHiveModel {
  @HiveField(0)
  int tmdbID;

  @HiveField(1)
  String title;

  @HiveField(2)
  String posterUrl;

  @HiveField(3)
  String backdropUrl;

  @HiveField(4)
  double voteAverage;

  @HiveField(5)
  String releaseDate;

  @HiveField(6)
  String overview;

  @HiveField(7)
  String category; // now_playing / popular / top_rated

  MovieHiveModel({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.category,
  });

  factory MovieHiveModel.fromMovieModel(MovieModel m, String category) {
    return MovieHiveModel(
      tmdbID: m.tmdbID,
      title: m.title,
      posterUrl: m.posterUrl,
      backdropUrl: m.backdropUrl,
      voteAverage: m.voteAverage,
      releaseDate: m.releaseDate,
      overview: m.overview,
      category: category,
    );
  }

  MovieModel toMovieModel() => MovieModel(
        tmdbID: tmdbID,
        title: title,
        posterUrl: posterUrl,
        backdropUrl: backdropUrl,
        voteAverage: voteAverage,
        releaseDate: releaseDate,
        overview: overview,
      );
}