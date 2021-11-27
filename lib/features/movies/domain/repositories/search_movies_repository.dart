import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

abstract class SearchMoviesRepository {
  Future<List<Movie>> searchMovies({required String title});
}
