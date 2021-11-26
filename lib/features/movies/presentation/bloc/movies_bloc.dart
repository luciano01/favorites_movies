import 'dart:async';

import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends Disposable {
  final GetPopularMovies usecase;

  MoviesBloc({required this.usecase}) {
    getPopularMovies();
  }

  final _popularMoviesSubject = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get outPopularMovies => _popularMoviesSubject.stream;
  Sink<List<Movie>> get inputPopularMovies => _popularMoviesSubject.sink;

  final List<Movie> _listOfPopularMovies = [];

  int page = 0;

  getPopularMovies() async {
    page++;
    var data = await usecase.getPopularMovies(page);
    for (var movie in data) {
      _listOfPopularMovies.add(movie);
    }
    inputPopularMovies.add(_listOfPopularMovies);
  }

  @override
  FutureOr onDispose() {
    _popularMoviesSubject.close();
  }
}
