import 'dart:convert';

import 'package:favorites_movies/features/movies/data/models/detail_model.dart';
import 'package:favorites_movies/features/movies/domain/entities/detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  var tDetailModel = const DetailModel(
    id: 1,
    originalTitle: 'originalTitle',
    backdropPath: 'backdropPath',
    genres: [],
    releaseDate: 'releaseDate',
    runtime: 1,
    voteAverage: 1.0,
    overview: 'overview',
  );

  final listOfDetails = <DetailModel>[tDetailModel];

  setUp(() {});

  test('Should be a subclass of Detail entity.', () {
    // assert
    expect(tDetailModel, isA<Detail>());
  });

  test('Should return a valid JSON.', () {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('detail.json'));
    // act
    final result = DetailModel.fromJson(jsonMap);
    // assert
    expect(result, tDetailModel);
  });

  test('Should return a valid List<Detail>.', () {
    // arrange
    final List list = jsonDecode(fixture('list_details.json'))["results"];
    // act
    final result = DetailModel.fromJsonList(list);
    // assert
    expect(result, listOfDetails);
  });

  test('Should return a json map containing the proper data.', () {
    // act
    final result = tDetailModel.toJson();
    // assert{
    final expectedMap = {
      "id": 1,
      "original_title": "originalTitle",
      "backdrop_path": "backdropPath",
      "genres": [],
      "release_date": "releaseDate",
      "runtime": 1,
      "vote_average": 1.0,
      "overview": "overview"
    };
    expect(result, expectedMap);
  });
}
