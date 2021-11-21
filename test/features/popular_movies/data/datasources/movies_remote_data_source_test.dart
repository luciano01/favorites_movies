import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:favorites_movies/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'movies_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MoviesRemoteDataSourceImpl moviesRemoteDataSourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    moviesRemoteDataSourceImpl = MoviesRemoteDataSourceImpl(client: mockClient);
  });

  final tListMovieModel =
      MovieModel.fromJsonList(jsonDecode(fixture('list_movies.json')));

  test(
      'Should perform a GET request on a URL with userName being the endpoint and with application/json header. ',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('list_movies.json'), 200));
    // act
    moviesRemoteDataSourceImpl.getPopularMovies();
    // assert
    verify(mockClient.get(
      Uri.parse(BaseUrl.urlPopularMovies),
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
        (_) async => http.Response(fixture('list_movies.json'), 200));
    // act
    final result = await moviesRemoteDataSourceImpl.getPopularMovies();
    // assert
    expect(result, equals(tListMovieModel));
  });

  test('Should throw a ServerException when the response code is 404 or other.',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong.', 404));
    // act
    final result = moviesRemoteDataSourceImpl.getPopularMovies();
    // assert
    expect(result, throwsA(const TypeMatcher<ServerException>()));
  });
}
