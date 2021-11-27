import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/search_movies_repository.dart';

class SearchMovies implements SearchMoviesRepository {
  final SearchMoviesRepository repository;

  SearchMovies({required this.repository});

  @override
  Future<List<Movie>> searchMovies({required String title}) async {
    return await repository.searchMovies(title: title);
  }
}
