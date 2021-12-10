import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/data/datasources/create_movie_data_source.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/create_movie_repository.dart';

class CreateMovieRepositoryImpl implements CreateMovieRepository {
  final CreateMovieDataSource dataSource;

  CreateMovieRepositoryImpl({required this.dataSource});

  @override
  Future<void> create({required Movie movie}) async {
    try {
      await dataSource.create(movie: movie);
    } on ServerException {
      throw ServerFailure('Internal Server Error!!!');
    }
  }
}
