import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:favorites_movies/features/movies/data/repositories/popular_movies_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_repository_impl_test.mocks.dart';

@GenerateMocks([
  PopularMoviesRemoteDataSource,
  NetworkInfo,
])
void main() {
  late PopularMoviesRepositoryImpl popularMoviesRepositoryImpl;
  late MockPopularMoviesRemoteDataSource mockPopularMoviesRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockPopularMoviesRemoteDataSource = MockPopularMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    popularMoviesRepositoryImpl = PopularMoviesRepositoryImpl(
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
    final result = await popularMoviesRepositoryImpl.getPopularMovies();
    // assert
    verify(mockPopularMoviesRemoteDataSource.getPopularMovies());
    expect(result, equals(tListOfMoviesModel));
  });
}
