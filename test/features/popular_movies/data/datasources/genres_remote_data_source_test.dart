import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:favorites_movies/features/movies/data/datasources/genres_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'genres_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late GenresRemoteDataSourceImpl genresRemoteDataSourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    genresRemoteDataSourceImpl = GenresRemoteDataSourceImpl(client: mockClient);
  });

  final tListOfGenreModel =
      GenreModel.fromJsonList(jsonDecode(fixture('list_genres.json')));

  test(
      'Should perform a GET request on a URL with userName being the endpoint and with application/json header. ',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('list_genres.json'), 200));
    // act
    genresRemoteDataSourceImpl.getGenres();
    // assert
    verify(mockClient.get(
      Uri.parse(BaseUrl.urlGenres),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  });

  test(
      'Should return a List<MovieModel> when the response code is 200 (success).',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('list_genres.json'), 200));
    // act
    final result = await genresRemoteDataSourceImpl.getGenres();
    // assert
    expect(result, equals(tListOfGenreModel));
  });

  test('Should throw a ServerException when the response code is 404 or other.',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong.', 404));
    // act
    final result = genresRemoteDataSourceImpl.getGenres();
    // assert
    expect(result, throwsA(const TypeMatcher<ServerException>()));
  });
}
