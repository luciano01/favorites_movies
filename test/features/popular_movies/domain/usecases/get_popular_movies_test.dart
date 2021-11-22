import 'package:dartz/dartz.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/popular_movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_popular_movies_test.mocks.dart';

@GenerateMocks([PopularMoviesRepository])
void main() {
  late GetPopularMovies usecase;
  late MockPopularMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockPopularMoviesRepository();
    usecase = GetPopularMovies(repository: mockMoviesRepository);
  });

  var tMovie = const Movie(
    id: 1,
    title: 'Title',
    releaseDate: 'releaseDate',
    posterPath: 'posterPath',
    genreIds: [1, 2, 3],
    isFavorite: false,
  );

  final listOfMovies = <Movie>[tMovie];

  test('Should return a List<Movie> from the repository.', () async {
    // arrange
    when(mockMoviesRepository.getPopularMovies())
        .thenAnswer((_) async => Right(listOfMovies));
    // act
    final result = await usecase.getPopularMovies();
    // assert
    expect(result, Right(listOfMovies));
    verify(mockMoviesRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
