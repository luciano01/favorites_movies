import 'dart:async';

import 'package:favorites_movies/features/movies/domain/entities/detail.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_movie_details.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class DetailsBloc extends Disposable {
  final GetMovieDetails usecase;

  DetailsBloc({required this.usecase});

  final _movieDetailsSubject = BehaviorSubject<Detail>();

  Stream<Detail>? get movieDetailsStream => _movieDetailsSubject.stream;
  Sink<Detail> get movieDetailsSink => _movieDetailsSubject.sink;

  getMovieDetails({required int id}) async {
    var data = await usecase.getMovieDetails(id: id);
    movieDetailsSink.add(data);
  }

  @override
  FutureOr onDispose() {
    _movieDetailsSubject.close();
  }
}
