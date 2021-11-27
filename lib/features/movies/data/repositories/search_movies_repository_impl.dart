import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/data/datasources/search_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/repositories/search_movies_repository.dart';

class SearchMoviesRepositoryImpl implements SearchMoviesRepository {
  final SearchMoviesRemoteDataSource remote;

  SearchMoviesRepositoryImpl({
    required this.remote,
  });

  @override
  Future<List<Movie>> searchMovies({required String title}) async {
    try {
      final remoteListOfMovies = await remote.searchMovies(title);
      return remoteListOfMovies;
    } on ServerException {
      throw ServerFailure('Internal Server Error.');
    } on HttpException {
      throw HttpFailure('Couldn\'t find the List of Popular Movies.');
    } on SocketException {
      throw SocketFailure('No Internet connection!');
    }
  }
}
