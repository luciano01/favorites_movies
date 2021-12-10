import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

abstract class UpdateMovieRepository {
  Future<void> update({required int id, required Movie movie});
  Future<void> updateIsCompleted({required int id, required Movie movie});
}
