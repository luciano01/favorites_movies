import 'dart:async';

import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/create_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/delete_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:favorites_movies/features/movies/domain/usecases/update_movie.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class MoviesBloc extends Disposable {
  final GetPopularMovies usecase;
  final CreateMovie createUsecase;
  final UpdateMovie updateUsecase;
  final DeleteMovie deleteUsecase;
  // ignore: prefer_typing_uninitialized_variables
  late final moviesFromBox;

  MoviesBloc({
    required this.usecase,
    required this.createUsecase,
    required this.updateUsecase,
    required this.deleteUsecase,
  }) {
    moviesFromBox = Hive.box<Movie>('movies');
    getPopularMovies();
  }

  final StreamController<List<Movie>> _popularMoviesSubject =
      StreamController<List<Movie>>.broadcast();

  Stream<List<Movie>> get outPopularMovies => _popularMoviesSubject.stream;
  Sink<List<Movie>> get inputPopularMovies => _popularMoviesSubject.sink;

  final List<Movie> _listOfPopularMovies = [];

  int page = 0;

  getPopularMovies() async {
    page++;
    Map<dynamic, Movie> boxMap = moviesFromBox.toMap();
    List<Movie> data = await usecase.getPopularMovies(page);

    data = data
        .map((movie) {
          if (boxMap.containsKey(movie.id)) {
            return movie.copy(isFavorite: true);
          } else {
            return movie.copy(isFavorite: false);
          }
        })
        .cast<Movie>()
        .toList();

    for (var movie in data) {
      _listOfPopularMovies.add(movie);
    }
    inputPopularMovies.add(_listOfPopularMovies);
  }

  addOrRemoveFavorite({required Movie movie}) async {
    if (!movie.isFavorite) {
      var movieToCreate = movie.copy(
        id: movie.id,
        isFavorite: !movie.isFavorite,
      );
      var index = _listOfPopularMovies.indexWhere(
        (element) => element.id == movie.id,
      );
      _listOfPopularMovies.replaceRange(
        index,
        index + 1,
        [movieToCreate],
      );
      await createUsecase.create(movie: movieToCreate);
    } else {
      var movieToUpdate = movie.copy(
        id: movie.id,
        isFavorite: !movie.isFavorite,
      );
      var index = _listOfPopularMovies.indexWhere(
        (element) => element.id == movie.id,
      );
      _listOfPopularMovies.replaceRange(
        index,
        index + 1,
        [movieToUpdate],
      );
      await deleteUsecase.delete(id: movie.id!);
    }
  }

  @override
  FutureOr onDispose() {
    _popularMoviesSubject.close();
  }
}
