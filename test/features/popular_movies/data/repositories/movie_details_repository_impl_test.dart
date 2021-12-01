import 'package:favorites_movies/features/movies/data/datasources/movie_details_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/models/detail_model.dart';
import 'package:favorites_movies/features/movies/data/repositories/movie_details_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_details_repository_impl_test.mocks.dart';

@GenerateMocks([MovieDetailsRemoteDataSource])
void main() {
  late MovieDetailsRepositoryImpl movieDetailsRepositoryImpl;
  late MockMovieDetailsRemoteDataSource mockMovieDetailsRemoteDataSource;

  setUp(() {
    mockMovieDetailsRemoteDataSource = MockMovieDetailsRemoteDataSource();
    movieDetailsRepositoryImpl = MovieDetailsRepositoryImpl(
      remote: mockMovieDetailsRemoteDataSource,
    );
  });

  var tDetailModel = const DetailModel(
    id: 1,
    originalTitle: 'originalTitle',
    backdropPath: 'backdropPath',
    genres: [],
    releaseDate: 'releaseDate',
    runtime: 1,
    voteAverage: 1.0,
    overview: 'overview',
  );

  var tId = 001;

  test('Should return data when call to remote data source is successful.',
      () async {
    // arrange
    when(movieDetailsRepositoryImpl.getMovieDetails(id: tId))
        .thenAnswer((_) async => tDetailModel);
    // act
    final result = await movieDetailsRepositoryImpl.getMovieDetails(id: tId);
    // assert
    verify(movieDetailsRepositoryImpl.getMovieDetails(id: tId));
    expect(result, equals(tDetailModel));
  });
}
