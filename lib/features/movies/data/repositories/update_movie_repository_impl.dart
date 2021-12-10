import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/data/datasources/update_movie_data_source.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/update_movie_repository.dart';

class UpdateMovieRepositoryImpl implements UpdateMovieRepository {
  final UpdateMovieDataSource dataSource;

  UpdateMovieRepositoryImpl({required this.dataSource});

  @override
  Future<void> update({required int id, required Movie movie}) async {
    try {
      await dataSource.update(id: id, movie: movie);
    } on ServerException {
      throw ServerFailure('Internal Server Error!!!');
    }
  }

  @override
  Future<void> updateIsCompleted(
      {required int id, required Movie movie}) async {
    try {
      await dataSource.updateIsCompleted(id: id, movie: movie);
    } on ServerException {
      throw ServerFailure('Internal Server Error!!!');
    }
  }
}
