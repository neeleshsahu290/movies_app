import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:movies_app/core/network/result.dart';
import 'package:movies_app/core/services/hive_service.dart';
import 'package:movies_app/core/services/hive_storage_service.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/movies/data/models/movie_model.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';
import 'package:movies_app/movies/domain/services/movies_api_service.dart';

class MoviesRepositoryImpl extends MoviesRespository {
  MoviesRepositoryImpl(this.dio);

  MoviesApiService get _moviesApiService =>
      MoviesApiService(dio, baseUrl: ApiConstants.apiEndpoint);

  @override
  final Dio dio;
  @override
  Future<Result<List<MovieModel>>> getNowPlayingMovies() async {
    return safeCall(
      _moviesApiService.getNowPlayingMovies(),
      entityMapper: (response) {
        final movies = response.results;

        HiveStorageService.saveMovies(movies, MoviesCategory.nowPlaying.value);

        return movies;
      },
    );
  }

  @override
  Future<Result<List<MovieModel>>> getPopularMovies() async {
    return safeCall(
      _moviesApiService.getPopularMovies(),
      entityMapper: (response) {
        final movies = response.results;

        HiveStorageService.saveMovies(movies, MoviesCategory.popular.value);

        return movies;
      },
    );
  }

  @override
  Future<Result<List<MovieModel>>> getTopRatedMovies() async {
    return safeCall(
      _moviesApiService.getTopRatedMovies(),
      entityMapper: (response) {
        final movies = response.results;

        HiveStorageService.saveMovies(movies, MoviesCategory.topRated.value);

        return movies;
      },
    );
  }

  @override
  Future<Result<List<List<MovieModel>>>> getMovies() async {
    final List<Result<List<MovieModel>>> results = await Future.wait([
      getNowPlayingMovies(),
      getPopularMovies(),
      getTopRatedMovies(),
    ]);

    for (final r in results) {
      if (r is Error<List<MovieModel>>) {
        return Error(r.message);
      }
    }

    final List<List<MovieModel>> movies = results
        .map((r) => (r as Success<List<MovieModel>>).data)
        .toList();

    return Success(movies);
  }

  @override
  Future<Result<MovieDetailsModel>> getMovieDetails(int movieId) async {
    return safeCall(
      dio.get(
        ApiConstants.movieDetailsPath(movieId),
        queryParameters: {
          'append_to_response': 'videos,credits,reviews,similar',
        },
      ),
      entityMapper: (response) {
        log("one");
        final details = MovieDetailsModel.fromJson(response.data);
        log("two");

        HiveStorageService.saveMovieDetails(details);
                log("three");

        return details;
      },
    );
  }

  @override
  Future<Result<List<MovieModel>>> getAllPopularMovies(int page) async {
    return safeCall(
      dio.get(ApiConstants.popularMoviesPath, queryParameters: {'page': page}),
      entityMapper: (response) => List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      ),
    );
  }

  @override
  Future<Result<List<MovieModel>>> getAllTopRatedMovies(int page) async {
    return safeCall(
      dio.get(ApiConstants.topRatedMoviesPath, queryParameters: {'page': page}),
      entityMapper: (response) => List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      ),
    );
  }

  @override
  Future<List<List<MovieModel>>> getMovieFromDB() async {
    final box = HiveService.instance.moviesBox;
    final values = box.values.toList();

    final nowPlaying = values
        .where((e) => e.category == MoviesCategory.nowPlaying.value)
        .map((e) => e.toMovieModel())
        .toList();
    final popular = values
        .where((e) => e.category == MoviesCategory.popular.value)
        .map((e) => e.toMovieModel())
        .toList();
    final topRated = values
        .where((e) => e.category == MoviesCategory.topRated.value)
        .map((e) => e.toMovieModel())
        .toList();

    return [nowPlaying, popular, topRated];
  }

  @override
  Future<MovieDetailsModel?> getMovieDetailsFromDB(int movieId) async {
    return HiveStorageService.getMovieDetails(movieId);
  }
}
