import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/movie_details_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'movie_details_remote_data_source_test.mocks.dart';

@GenerateMocks([
  http.Client,
  NetworkInfo,
], customMocks: [
  MockSpec<NavigatorObserver>(returnNullOnMissingStub: true)
])
void main() {
  late MovieDetailsRemoteDataSourceImpl movieDetailsRemoteDataSourceImpl;
  late MockClient mockClient;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockClient = MockClient();
    mockNetworkInfo = MockNetworkInfo();
    movieDetailsRemoteDataSourceImpl = MovieDetailsRemoteDataSourceImpl(
      client: mockClient,
      network: mockNetworkInfo,
    );
  });

  var tId = 01;
  final listFromFixture = fixture('list_details.json');
  final body = jsonDecode(listFromFixture);
  final results = body["results"];
  final tListOfDetailModel = DetailModel.fromJsonList(results);

  test('Should return a List<DetailModel> when the response code is 200.',
      () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(listFromFixture, 200));
    // act
    final result =
        await movieDetailsRemoteDataSourceImpl.getMovieDetails(id: tId);
    // assert
    expect(result, equals(tListOfDetailModel));
  });

  test(
      'Should throw a HttpException when the response code is different from 200 or 404.',
      () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('404', 404));
    // act
    final result = movieDetailsRemoteDataSourceImpl.getMovieDetails(id: tId);
    // assert
    expect(result, throwsA(const TypeMatcher<HttpException>()));
  });

  test(
      'Should throw a ServerException when the response code is different from 200 or 404.',
      () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('500', 500));
    // act
    final result = movieDetailsRemoteDataSourceImpl.getMovieDetails(id: tId);
    // assert
    expect(result, throwsA(const TypeMatcher<ServerException>()));
  });
}
