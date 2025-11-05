import 'package:dio/dio.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';
import 'package:movies_app/movies/data/models/movie_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'movies_api_service.g.dart';   

@RestApi()
abstract class MoviesApiService {
  factory MoviesApiService(Dio dio, {String baseUrl}) =
      _MoviesApiService;

  // Now Playing Movies
  @GET(ApiConstants.nowPlayingMoviesPath)
  Future<MovieResponse> getNowPlayingMovies();

  // Popular Movies
  @GET(ApiConstants.popularMoviesPath)
  Future<MovieResponse> getPopularMovies({@Query('page') int page = 1});

  // Top Rated Movies
  @GET(ApiConstants.topRatedMoviesPath)
  Future<MovieResponse> getTopRatedMovies();

  // Movie Details (with append_to_response)
  @GET('movie/{movie_id}')
  Future<MovieDetailsModel> getMovieDetails(
    @Path('movie_id') int movieId, {
    @Query('append_to_response')
    String append = 'videos,credits,reviews,similar',
  });
}
