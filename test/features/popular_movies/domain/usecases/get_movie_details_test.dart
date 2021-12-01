import 'package:favorites_movies/features/movies/domain/entities/detail.dart';
import 'package:favorites_movies/features/movies/domain/repositories/movie_details_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_movie_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_movie_details_test.mocks.dart';

@GenerateMocks([MovieDetailsRepository])
void main() {
  late GetMovieDetails getMovieDetails;
  late MockMovieDetailsRepository mockMovieDetailsRepository;

  setUp(() {
    mockMovieDetailsRepository = MockMovieDetailsRepository();
    getMovieDetails = GetMovieDetails(
      repository: mockMovieDetailsRepository,
    );
  });

  var tId = 001;

  var tDetail = const Detail(
    id: 1,
    originalTitle: 'originalTitle',
    backdropPath: 'backdropPath',
    genres: [],
    releaseDate: 'releaseDate',
    runtime: 1,
    voteAverage: 1.0,
    overview: 'overview',
  );

  test('Should return a Detail from the repository.', () async {
    // arrange
    when(mockMovieDetailsRepository.getMovieDetails(id: tId))
        .thenAnswer((_) async => tDetail);
    // act
    final result = await getMovieDetails.getMovieDetails(id: tId);
    // assert
    expect(result, tDetail);
    verify(mockMovieDetailsRepository.getMovieDetails(id: tId));
    verifyNoMoreInteractions(mockMovieDetailsRepository);
  });
}
