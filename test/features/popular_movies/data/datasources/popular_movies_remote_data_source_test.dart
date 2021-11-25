import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'popular_movies_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late PopularMoviesRemoteDataSourceImpl popularMoviesRemoteDataSourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    popularMoviesRemoteDataSourceImpl = PopularMoviesRemoteDataSourceImpl(
      client: mockClient,
    );
  });

  final listFromFixture = fixture('list_movies.json');
  final body = jsonDecode(listFromFixture);
  final results = body["results"];
  final tListOfMovieModel = MovieModel.fromJsonList(results);

  test(
      'Should perform a GET request on a URL endpoint and with application/json header.',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(listFromFixture, 200));
    // act
    popularMoviesRemoteDataSourceImpl.getPopularMovies();
    // assert
    verify(mockClient.get(
      Uri.parse(BaseUrl.urlPopularMovies),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  });

  test('Should return a List<MovieModel> when the response code is 200.',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(listFromFixture, 200));
    // act
    final result = await popularMoviesRemoteDataSourceImpl.getPopularMovies();
    // assert
    expect(result, equals(tListOfMovieModel));
  });

  test('Should throw a HttpException when the response code is 404.', () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('404', 404));
    // act
    final result = popularMoviesRemoteDataSourceImpl.getPopularMovies();
    // assert
    expect(result, throwsA(const TypeMatcher<HttpException>()));
  });

  test(
      'Should throw a ServerException when the response code is different from 200 or 404.',
      () async {
    // arrange
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('500', 500));
    // act
    final result = popularMoviesRemoteDataSourceImpl.getPopularMovies();
    // assert
    expect(result, throwsA(const TypeMatcher<ServerException>()));
  });
}
