import 'dart:convert';

import 'package:favorites_movies/features/movies/data/models/genre_model.dart';
import 'package:favorites_movies/features/movies/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  var tGenreModel = const GenreModel(id: 1, name: 'Action');

  final tListOfGenreModel = <GenreModel>[tGenreModel];

  setUp(() {});

  test('Should be a subclass of Genre entity.', () {
    // assert
    expect(tGenreModel, isA<Genre>());
  });

  test('Should return a valid JSON.', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('genre.json'));
    // act
    final result = GenreModel.fromJson(jsonMap);
    // assert
    expect(result, tGenreModel);
  });

  test('Should return a valid List<GenreModel>.', () {
    // arrange
    final List list = jsonDecode(fixture('List_genres.json'));
    // act
    final result = GenreModel.fromJsonList(list);
    // assert
    expect(result, tListOfGenreModel);
  });

  test('Should return a json map containing the proper data.', () {
    // act
    final result = tGenreModel.toJson();
    // assert
    final expectedJson = {
      "id": 1,
      "name": "Action",
    };
    expect(result, expectedJson);
  });
}
