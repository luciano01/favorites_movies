import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:hive/hive.dart';

abstract class DeleteMovieDataSource {
  Future<void> delete({required int id});
}

class DeleteMovieDataSourceImpl implements DeleteMovieDataSource {
  DeleteMovieDataSourceImpl();

  @override
  Future<void> delete({required int id}) async {
    final box = Hive.box<Movie>('movies');

    if (!id.isNegative) {
      box.delete(id);
    } else {
      throw ServerException();
    }
  }
}
