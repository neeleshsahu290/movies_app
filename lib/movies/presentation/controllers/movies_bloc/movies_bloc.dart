import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/result.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';

import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_event.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRespository _moviesRepository;

  MoviesBloc(this._moviesRepository) : super(const MoviesState()) {
    on<GetMoviesEvent>(_getMovies);
  }

  Future<void> _getMovies(
    GetMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.status == RequestStatus.loaded) {
      final r = await _moviesRepository.getMovies();
      r.when(
        success: (d) => emit(state.copyWith(movies: d)),
        error: (_) {},
      );
      event.completer?.complete();

      return;
    }

    emit(state.copyWith(status: RequestStatus.loading));

    final localData = await _moviesRepository.getMovieFromDB();
    if (localData.isNotEmpty && localData.first.isNotEmpty) {
      emit(state.copyWith(status: RequestStatus.loaded, movies: localData));
    }
    final result = await _moviesRepository.getMovies();
    result.when(
      success: (data) {
        emit(state.copyWith(status: RequestStatus.loaded, movies: data));
      },
      error: (message) {
        if (localData.isEmpty ||
            localData.isNotEmpty && localData.first.isEmpty) {
          emit(state.copyWith(status: RequestStatus.error, message: message));
        }
      },
    );
  }
}
