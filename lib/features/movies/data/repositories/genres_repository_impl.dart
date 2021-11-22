import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/genres_remote_data_source.dart';
import 'package:favorites_movies/features/movies/domain/entities/genre.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:favorites_movies/features/movies/domain/repositories/genres_repository.dart';

class GenresRepositoryImpl implements GenresRepository {
  final GenresRemoteDataSource remote;
  final NetworkInfo network;

  GenresRepositoryImpl({
    required this.remote,
    required this.network,
  });

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    if (await network.isConnected) {
      try {
        final remoteGenres = await remote.getGenres();
        return Right(remoteGenres);
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      return Left(ServerFailure('Server Failure'));
    }
  }
}
