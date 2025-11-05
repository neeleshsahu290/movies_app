import 'package:movies_app/core/network/repository/base_repository.dart';
import 'package:movies_app/core/network/result.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';
import 'package:movies_app/movies/data/models/movie_model.dart';

abstract class MoviesRespository extends BaseRepository {
  Future<Result<List<MovieModel>>> getNowPlayingMovies();
  Future<Result<List<MovieModel>>> getPopularMovies();
  Future<Result<List<MovieModel>>> getTopRatedMovies();
  Future<Result<List<List<MovieModel>>>> getMovies();
  Future<List<List<MovieModel>>> getMovieFromDB();

  Future<Result<MovieDetailsModel>> getMovieDetails(int movieId);
  Future<MovieDetailsModel?> getMovieDetailsFromDB(int movieId);

  Future<Result<List<MovieModel>>> getAllPopularMovies(int page);
  Future<Result<List<MovieModel>>> getAllTopRatedMovies(int page);
}
