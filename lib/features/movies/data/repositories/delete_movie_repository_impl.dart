import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/data/datasources/delete_movie_data_source.dart';
import 'package:favorites_movies/features/movies/domain/repositories/delete_movie_repository.dart';

class DeleteMovieRepositoryImpl implements DeleteMovieRepository {
  final DeleteMovieDataSource dataSource;

  DeleteMovieRepositoryImpl({required this.dataSource});

  @override
  Future<void> delete({required int id}) async {
    try {
      await dataSource.delete(id: id);
    } on ServerException {
      throw ServerFailure('Internal Server Error!!!');
    }
  }
}
