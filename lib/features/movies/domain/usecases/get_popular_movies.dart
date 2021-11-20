import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:favorites_movies/features/movies/domain/repositories/movies_repository.dart';

class GetPopularMovies implements MoviesRepository {
  final MoviesRepository repository;

  GetPopularMovies({required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    return await repository.getPopularMovies();
  }
}
