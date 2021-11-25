import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/popular_movies_repository.dart';

class GetPopularMovies implements PopularMoviesRepository {
  final PopularMoviesRepository repository;

  GetPopularMovies({required this.repository});

  @override
  Future<List<Movie>> getPopularMovies() async {
    return await repository.getPopularMovies();
  }
}
