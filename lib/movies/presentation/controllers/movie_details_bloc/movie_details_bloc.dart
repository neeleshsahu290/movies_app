import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/network/result.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MoviesRespository _moviesRepository;

  MovieDetailsBloc(this._moviesRepository) : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
  }

  Future<void> _getMovieDetails(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final localData = await _moviesRepository.getMovieDetailsFromDB(event.id);
    if (localData != null) {
      emit(
        state.copyWith(status: RequestStatus.loaded, movieDetails: localData),
      );
    }
    final result = await _moviesRepository.getMovieDetails(event.id);

    result.when(
      success: (data) {
        emit(state.copyWith(status: RequestStatus.loaded, movieDetails: data));
      },
      error: (msg) {
        if (localData == null) {
          emit(state.copyWith(status: RequestStatus.error, message: msg));
        }
      },
    );
  }
}
