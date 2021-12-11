import 'dart:async';

import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/create_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/delete_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/search_movies.dart';
import 'package:favorites_movies/features/movies/domain/usecases/update_movie.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Disposable {
  final SearchMovies usecase;
  final CreateMovie createUsecase;
  final UpdateMovie updateUsecase;
  final DeleteMovie deleteUsecase;

  final _searchMoviesSubject = BehaviorSubject<List<Movie>>();

  // ignore: prefer_typing_uninitialized_variables
  late final moviesFromBox;

  SearchBloc({
    required this.usecase,
    required this.createUsecase,
    required this.updateUsecase,
    required this.deleteUsecase,
  }) {
    searchMovieByName(textEditingController.text);
    moviesFromBox = Hive.box<Movie>('movies');
  }

  TextEditingController textEditingController = TextEditingController();

  Stream<List<Movie>> get moviesStream => _searchMoviesSubject.stream;
  Sink<List<Movie>> get moviesSink => _searchMoviesSubject.sink;

  searchMovieByName(String title) async {
    if (title.isEmpty) {
      var data = await usecase.searchMovies(title: '2021');
      List<Movie> tempList = [];
      Map<dynamic, Movie> boxMap = moviesFromBox.toMap();

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
        tempList.add(movie);
      }
      moviesSink.add(tempList);
    } else {
      var data = await usecase.searchMovies(title: textEditingController.text);
      List<Movie> tempList = [];
      Map<dynamic, Movie> boxMap = moviesFromBox.toMap();

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
        tempList.add(movie);
      }
      moviesSink.add(tempList);
    }
  }

  addOrRemoveFavorite({required Movie movie}) async {
    if (!movie.isFavorite) {
      var movieToCreate = movie.copy(
        id: movie.id,
        isFavorite: !movie.isFavorite,
      );
      var list = _searchMoviesSubject.value;
      var index = list.indexWhere(
        (element) => element.id == movie.id,
      );
      list.replaceRange(
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
      var list = _searchMoviesSubject.value;
      var index = list.indexWhere(
        (element) => element.id == movie.id,
      );
      list.replaceRange(
        index,
        index + 1,
        [movieToUpdate],
      );
      await deleteUsecase.delete(id: movie.id!);
    }
  }

  @override
  FutureOr onDispose() {
    _searchMoviesSubject.close();
    textEditingController.dispose();
  }
}
