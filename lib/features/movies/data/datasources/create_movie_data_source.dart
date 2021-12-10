import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:hive/hive.dart';

abstract class CreateMovieDataSource {
  Future<void> create({required Movie movie});
}

class CreateMovieDataSourceImpl implements CreateMovieDataSource {
  CreateMovieDataSourceImpl();

  @override
  Future<void> create({required Movie movie}) async {
    final box = Hive.box<Movie>('movies');

    if (!movie.id!.isNegative) {
      box.put(movie.id, movie);
    } else {
      throw ServerException();
    }
  }
}
