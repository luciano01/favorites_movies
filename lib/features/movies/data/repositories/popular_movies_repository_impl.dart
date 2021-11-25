import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/popular_movies_repository.dart';

class PopularMoviesRepositoryImpl implements PopularMoviesRepository {
  final PopularMoviesRemoteDataSource remote;
  final NetworkInfo network;

  PopularMoviesRepositoryImpl({
    required this.remote,
    required this.network,
  });

  @override
  Future<List<Movie>> getPopularMovies() async {
    if (await network.isConnected) {
      try {
        final remoteListOfMovies = await remote.getPopularMovies();
        return remoteListOfMovies;
      } on ServerException {
        throw ServerFailure('Internal Server Error.');
      } on HttpException {
        throw HttpFailure('Couldn\'t find the List of Popular Movies.');
      }
    } else {
      throw SocketFailure('No Internet connection!');
    }
  }
}
