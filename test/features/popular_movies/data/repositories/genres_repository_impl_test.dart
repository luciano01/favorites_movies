import 'package:dartz/dartz.dart';
import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/genres_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/genre_model.dart';
import 'package:favorites_movies/features/movies/data/repositories/genres_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'genres_repository_impl_test.mocks.dart';

@GenerateMocks([
  GenresRemoteDataSource,
  NetworkInfo,
])
void main() {
  late GenresRepositoryImpl genresRepositoryImpl;
  late MockGenresRemoteDataSource mockGenreRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGenreRemoteDataSource = MockGenresRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    genresRepositoryImpl = GenresRepositoryImpl(
      remote: mockGenreRemoteDataSource,
      network: mockNetworkInfo,
    );
  });

  var tGenreModel = const GenreModel(id: 1, name: 'Action');
  final tListOfGenres = <GenreModel>[tGenreModel];

  test('Should return data when call to remote data source is successful.',
      () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockGenreRemoteDataSource.getGenres())
        .thenAnswer((_) async => tListOfGenres);
    // act
    final result = await genresRepositoryImpl.getGenres();
    // assert
    verify(mockGenreRemoteDataSource.getGenres());
    expect(result, equals(Right(tListOfGenres)));
  });

  test(
      'Should return ServerFailure when the call to remote data source is unsuccessful.',
      () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockGenreRemoteDataSource.getGenres()).thenThrow(ServerException());
    // act
    final result = await genresRepositoryImpl.getGenres();
    // assert
    verify(mockGenreRemoteDataSource.getGenres());
    verifyNoMoreInteractions(mockGenreRemoteDataSource);
    expect(result, equals(Left(ServerFailure('Server Failure'))));
  });
}
