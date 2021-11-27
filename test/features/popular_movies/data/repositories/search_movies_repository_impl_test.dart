import 'package:favorites_movies/features/movies/data/datasources/search_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:favorites_movies/features/movies/data/repositories/search_movies_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_movies_repository_impl.mocks.dart';

@GenerateMocks([SearchMoviesRemoteDataSource])
void main() {
  late SearchMoviesRepositoryImpl searchMoviesRepositoryImpl;
  late MockSearchMoviesRemoteDataSource mockSearchMoviesRemoteDataSource;

  setUp(() {
    mockSearchMoviesRemoteDataSource = MockSearchMoviesRemoteDataSource();
    searchMoviesRepositoryImpl = SearchMoviesRepositoryImpl(
      remote: mockSearchMoviesRemoteDataSource,
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

  var tTitle = 'Title';

  final tListOfMoviesModel = <MovieModel>[tMovieModel];

  test('Should return data when call to remote data source is successful.',
      () async {
    // arrange
    when(mockSearchMoviesRemoteDataSource.searchMovies(tTitle))
        .thenAnswer((_) async => tListOfMoviesModel);
    // act
    final result = await searchMoviesRepositoryImpl.searchMovies(title: tTitle);
    // assert
    verify(mockSearchMoviesRemoteDataSource.searchMovies(tTitle));
    expect(result, equals(tListOfMoviesModel));
  });
}
