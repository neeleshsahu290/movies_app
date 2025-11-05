import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class GetMoviesEvent extends MoviesEvent {
  final Completer<void>? completer;

  const GetMoviesEvent({this.completer});

  @override
  List<Object?> get props => [completer];
}
