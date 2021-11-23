import 'package:dartz/dartz.dart';
import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:favorites_movies/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_repository_impl_test.mocks.dart';

@GenerateMocks([
  PopularMoviesRemoteDataSource,
  NetworkInfo,
])
void main() {
  late PopularMoviesRepositoryImpl moviesRepositoryImpl;
  late MockPopularMoviesRemoteDataSource mockPopularMoviesRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockPopularMoviesRemoteDataSource = MockPopularMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    moviesRepositoryImpl = PopularMoviesRepositoryImpl(
      remote: mockPopularMoviesRemoteDataSource,
      network: mockNetworkInfo,
    );
  });

  var tMovieModel = const MovieModel(
    id: 1,
    title: 'Title',
    releaseDate: 'releaseDate',
    posterPath: 'posterPath',
    genreIds: [1, 2, 3],
    isFavorite: false,
  );

  final tListOfMoviesModel = <MovieModel>[tMovieModel];

  test('Should return data when call to remote data source is successful.',
      () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    when(mockPopularMoviesRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tListOfMoviesModel);
    // act
    final result = await moviesRepositoryImpl.getPopularMovies();
    // assert
    verify(mockPopularMoviesRemoteDataSource.getPopularMovies());
    expect(result, equals(Right(tListOfMoviesModel)));
  });

  test(
      'Should return ServerFailure when the call to remote data source is unsuccessful.',
      () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    when(mockPopularMoviesRemoteDataSource.getPopularMovies())
        .thenThrow(ServerException());
    // act
    final result = await moviesRepositoryImpl.getPopularMovies();
    // assert
    verify(mockPopularMoviesRemoteDataSource.getPopularMovies());
    verifyNoMoreInteractions(mockPopularMoviesRemoteDataSource);
    expect(result, equals(Left(ServerFailure('ServerFailure'))));
  });
}
