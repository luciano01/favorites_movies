import 'dart:convert';

import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  var tMovieModel = const MovieModel(
    id: 1,
    title: 'title',
    releaseDate: 'releaseDate',
    posterPath: 'posterPath',
    genreIds: [1, 2, 3],
    isFavorite: false,
  );

  final tListOfMovieModel = <MovieModel>[tMovieModel];

  setUp(() {});

  test('Should be a subclass of Movie entity.', () {
    // assert
    expect(tMovieModel, isA<Movie>());
  });

  test('Should return a valid JSON.', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('movie.json'));
    // act
    final result = MovieModel.fromJson(jsonMap);
    // assert
    expect(result, tMovieModel);
  });

  test('Should return a valid List<Movie>.', () {
    // arrange
    final List list = jsonDecode(fixture('list_movies.json'))["results"];
    // act
    final result = MovieModel.fromJsonList(list);
    // assert
    expect(result, tListOfMovieModel);
  });

  test('Should return a json map containing the proper data.', () {
    // act
    final result = tMovieModel.toJson();
    // assert{
    final expectedMap = {
      "id": 1,
      "title": "title",
      "release_date": "releaseDate",
      "poster_path": "posterPath",
      "genre_ids": [1, 2, 3],
      "isFavorite": false
    };
    expect(result, expectedMap);
  });
}
