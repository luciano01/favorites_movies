import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/search_movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_movies_test.mocks.dart';

@GenerateMocks([SearchMoviesRepository])
void main() {
  late SearchMovies searchMovies;
  late MockSearchMoviesRepository mockSearchMoviesRepository;

  setUp(() {
    mockSearchMoviesRepository = MockSearchMoviesRepository();
    searchMovies = SearchMovies(
      repository: mockSearchMoviesRepository,
    );
  });

  var tTitle = 'Title';

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
    when(mockSearchMoviesRepository.searchMovies(title: tTitle))
        .thenAnswer((_) async => listOfMovies);
    // act
    final result = await searchMovies.searchMovies(title: tTitle);
    // assert
    expect(result, listOfMovies);
    verify(mockSearchMoviesRepository.searchMovies(title: tTitle));
    verifyNoMoreInteractions(mockSearchMoviesRepository);
  });
}
