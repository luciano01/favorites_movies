import 'package:favorites_movies/features/movies/domain/entities/genre.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:favorites_movies/features/movies/domain/repositories/genres_repository.dart';

class GetGenres implements GenresRepository {
  final GenresRepository repository;

  GetGenres({required this.repository});

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    return await repository.getGenres();
  }
}
