import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

abstract class CreateMovieRepository {
  Future<void> create({required Movie movie});
}
