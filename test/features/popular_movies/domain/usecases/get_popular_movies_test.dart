import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/popular_movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_popular_movies_test.mocks.dart';

@GenerateMocks([PopularMoviesRepository])
void main() {
  late GetPopularMovies getPopularMovies;
  late MockPopularMoviesRepository mockPopularMoviesRepository;

  setUp(() {
    mockPopularMoviesRepository = MockPopularMoviesRepository();
    getPopularMovies = GetPopularMovies(
      repository: mockPopularMoviesRepository,
    );
  });

  var tMovie = Movie(
    id: 1,
    title: 'Title',
    releaseDate: 'releaseDate',
    posterPath: 'posterPath',
    overview: 'overview',
    genreIds: const [1, 2, 3],
    isFavorite: false,
  );

  final listOfMovies = <Movie>[tMovie];

  test('Should return a List<Movie> from the repository.', () async {
    // arrange
    when(mockPopularMoviesRepository.getPopularMovies(1))
        .thenAnswer((_) async => listOfMovies);
    // act
    final result = await getPopularMovies.getPopularMovies(1);
    // assert
    expect(result, listOfMovies);
    verify(mockPopularMoviesRepository.getPopularMovies(1));
    verifyNoMoreInteractions(mockPopularMoviesRepository);
  });
}
