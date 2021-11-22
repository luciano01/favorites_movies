import 'package:dartz/dartz.dart';
import 'package:favorites_movies/features/movies/domain/entities/genre.dart';
import 'package:favorites_movies/features/movies/domain/repositories/genres_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_genres.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_genres_test.mocks.dart';

@GenerateMocks([GenresRepository])
void main() {
  late GetGenres usecase;
  late MockGenresRepository mockGenresRepository;

  setUp(() {
    mockGenresRepository = MockGenresRepository();
    usecase = GetGenres(repository: mockGenresRepository);
  });

  var tGenre = const Genre(id: 1, name: 'Action');

  final tListOfGenres = <Genre>[tGenre];

  test('Should return a List<Genre> from the repository.', () async {
    // arrange
    when(mockGenresRepository.getGenres())
        .thenAnswer((_) async => Right(tListOfGenres));
    // act
    final result = await usecase.getGenres();
    // assert
    expect(result, Right(tListOfGenres));
    verify(mockGenresRepository.getGenres());
    verifyNoMoreInteractions(mockGenresRepository);
  });
}
