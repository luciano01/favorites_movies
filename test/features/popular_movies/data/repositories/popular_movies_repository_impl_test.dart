import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:favorites_movies/features/movies/data/repositories/popular_movies_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_repository_impl_test.mocks.dart';

@GenerateMocks([PopularMoviesRemoteDataSource])
void main() {
  late PopularMoviesRepositoryImpl popularMoviesRepositoryImpl;
  late MockPopularMoviesRemoteDataSource mockPopularMoviesRemoteDataSource;

  setUp(() {
    mockPopularMoviesRemoteDataSource = MockPopularMoviesRemoteDataSource();
    popularMoviesRepositoryImpl = PopularMoviesRepositoryImpl(
      remote: mockPopularMoviesRemoteDataSource,
    );
  });

  var tMovieModel = const MovieModel(
    id: 1,
    title: 'Title',
    releaseDate: 'releaseDate',
    posterPath: 'posterPath',
    overview: 'overview',
    genreIds: [1, 2, 3],
    isFavorite: false,
  );

  final tListOfMoviesModel = <MovieModel>[tMovieModel];

  test('Should return data when call to remote data source is successful.',
      () async {
    // arrange
    when(mockPopularMoviesRemoteDataSource.getPopularMovies(1))
        .thenAnswer((_) async => tListOfMoviesModel);
    // act
    final result = await popularMoviesRepositoryImpl.getPopularMovies(1);
    // assert
    verify(mockPopularMoviesRemoteDataSource.getPopularMovies(1));
    expect(result, equals(tListOfMoviesModel));
  });
}
