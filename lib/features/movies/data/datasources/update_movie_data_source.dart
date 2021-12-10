import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:hive/hive.dart';

abstract class UpdateMovieDataSource {
  Future<void> update({required int id, required Movie movie});
  Future<void> updateIsCompleted({required int id, required Movie movie});
}

class UpdateMovieDataSourceImpl implements UpdateMovieDataSource {
  UpdateMovieDataSourceImpl();

  @override
  Future<void> update({required int id, required Movie movie}) async {
    final box = Hive.box<Movie>('movies');

    if (!id.isNegative) {
      box.putAt(id, movie);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateIsCompleted(
      {required int id, required Movie movie}) async {
    final box = Hive.box<Movie>('movies');
    var userToUpdate = movie.copy(
      isFavorite: !movie.isFavorite,
    );

    if (!id.isNegative) {
      box.putAt(id, userToUpdate);
    } else {
      throw ServerException();
    }
  }
}
