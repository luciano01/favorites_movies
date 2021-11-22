import 'package:dartz/dartz.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

abstract class PopularMoviesRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies();
}
