import 'package:movies_app/core/services/hive_service.dart';
import 'package:movies_app/movies/data/models/db/movie_details_hive.model.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';
import 'package:movies_app/movies/data/models/db/movie_hive_model.dart';
import 'package:movies_app/movies/data/models/movie_model.dart';

class HiveStorageService {
  HiveStorageService._(); // private constructor

  static final moviesBox = HiveService.instance.moviesBox;
  static final detailsBox = HiveService.instance.moviesDetailsBox;

  static Future<void> saveMovies(List<MovieModel> list, String category) async {
    // remove old category movies
    final keysToDelete = moviesBox.values
        .where((e) => e.category == category)
        .map((e) => e.tmdbID)
        .toList();

    for (final id in keysToDelete) {
      await moviesBox.delete(id);
    }

    // insert new updated movies
    for (final m in list) {
      await moviesBox.put(m.tmdbID, MovieHiveModel.fromMovieModel(m, category));
    }
  }

  static List<MovieModel> getMovies(String category) {
    return moviesBox.values
        .where((e) => e.category == category)
        .map((e) => e.toMovieModel())
        .toList();
  }

  /// save one detail object
  static Future<void> saveMovieDetails(MovieDetailsModel details) async {
    final hiveModel = MovieDetailsHiveModel.fromMovieDetails(details);
    await detailsBox.put(details.tmdbID, hiveModel);
  }

  /// get detail object
  static MovieDetailsModel? getMovieDetails(int tmdbId) {
    final hive = detailsBox.get(tmdbId);
    if (hive == null) return null;
    return hive.toMovieDetailsModel();
  }
}
