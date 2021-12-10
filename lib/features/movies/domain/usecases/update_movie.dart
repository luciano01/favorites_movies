import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/update_movie_repository.dart';

class UpdateMovie implements UpdateMovieRepository {
  final UpdateMovieRepository repository;

  UpdateMovie({required this.repository});

  @override
  Future<void> update({required int id, required Movie movie}) async {
    await repository.update(id: id, movie: movie);
  }

  @override
  Future<void> updateIsCompleted({
    required int id,
    required Movie movie,
  }) async {
    await repository.updateIsCompleted(id: id, movie: movie);
  }
}
