import 'package:dartz/dartz.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/domain/entities/genre.dart';

abstract class GenresRepository {
  Future<Either<Failure, List<Genre>>> getGenres();
}
