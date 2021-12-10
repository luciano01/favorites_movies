import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/create_movie_repository.dart';

class CreateMovie implements CreateMovieRepository {
  final CreateMovieRepository repository;

  CreateMovie({required this.repository});

  @override
  Future<void> create({required Movie movie}) async {
    await repository.create(movie: movie);
  }
}
