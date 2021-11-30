import 'dart:async';

import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/search_movies.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Disposable {
  final SearchMovies usecase;

  final _searchMoviesSubject = BehaviorSubject<List<Movie>>();

  SearchBloc({required this.usecase}) {
    searchMovieByName(textEditingController.text);
  }

  TextEditingController textEditingController = TextEditingController();

  Stream<List<Movie>> get moviesStream => _searchMoviesSubject.stream;
  Sink<List<Movie>> get moviesSink => _searchMoviesSubject.sink;

  searchMovieByName(String title) async {
    if (title.isEmpty) {
      var data = await usecase.searchMovies(title: '2021');
      List<Movie> tempList = [];
      for (var movie in data) {
        tempList.add(movie);
      }
      moviesSink.add(tempList);
    } else {
      var data = await usecase.searchMovies(title: textEditingController.text);
      List<Movie> tempList = [];
      for (var movie in data) {
        tempList.add(movie);
      }
      moviesSink.add(tempList);
    }
  }

  @override
  FutureOr onDispose() {
    _searchMoviesSubject.close();
    textEditingController.dispose();
  }
}
