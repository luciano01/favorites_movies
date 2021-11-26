import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

abstract class PopularMoviesRepository {
  Future<List<Movie>> getPopularMovies(int page);
}
