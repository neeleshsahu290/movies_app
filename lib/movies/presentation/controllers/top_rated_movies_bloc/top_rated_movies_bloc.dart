import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/network/result.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc(this._moviesRepository)
    : super(const TopRatedMoviesState()) {
    on<TopRatedMoviesEvent>(_getAllTopRatedMovies);
    on<FetchMoreTopRatedMoviesEvent>(_fetchMoreMovies);
  }

  final MoviesRespository _moviesRepository;
  int page = 1;

  Future<void> _getAllTopRatedMovies(
    TopRatedMoviesEvent event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getMovies(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getMovies(emit);
    } else if (state.status == GetAllRequestStatus.error) {
      emit(state.copyWith(status: GetAllRequestStatus.loading));
      await _getMovies(emit);
    }
  }

  Future<void> _getMovies(Emitter<TopRatedMoviesState> emit) async {
    final result = await _moviesRepository.getAllTopRatedMovies(page);
    result.when(
      success: (data) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            movies: state.movies + data,
          ),
        );
      },
      error: (_) {
        emit(state.copyWith(status: GetAllRequestStatus.error));
      },
    );
  }

  Future<void> _fetchMoreMovies(
    FetchMoreTopRatedMoviesEvent event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    final result = await _moviesRepository.getAllTopRatedMovies(page);

    result.when(
      success: (data) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            movies: state.movies + data,
          ),
        );
      },
      error: (_) {
        emit(state.copyWith(status: GetAllRequestStatus.fetchMoreError));
      },
    );
  }
}
