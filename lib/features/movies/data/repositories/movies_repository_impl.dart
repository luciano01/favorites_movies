import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:favorites_movies/features/movies/domain/repositories/popular_movies_repository.dart';

class MoviesRepositoryImpl implements PopularMoviesRepository {
  final MoviesRemoteDataSource remote;
  final NetworkInfo network;

  MoviesRepositoryImpl({
    required this.remote,
    required this.network,
  });

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    if (await network.isConnected) {
      try {
        final remoteMovies = await remote.getPopularMovies();
        return Right(remoteMovies);
      } on ServerException {
        return Left(ServerFailure('ServerFailure'));
      }
    } else {
      return Left(ServerFailure('ServerFailure'));
    }
  }
}
