import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/data/datasources/movie_details_remote_data_source.dart';
import 'package:favorites_movies/features/movies/domain/entities/detail.dart';
import 'package:favorites_movies/features/movies/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remote;

  MovieDetailsRepositoryImpl({
    required this.remote,
  });

  @override
  Future<List<Detail>> getMovieDetails({required int id}) async {
    try {
      final remoteListOfMovieDetails = await remote.getMovieDetails(id: id);
      return remoteListOfMovieDetails;
    } on ServerException {
      throw ServerFailure('Internal Server Error.');
    } on HttpException {
      throw HttpFailure('Couldn\'t find the List of Movie Details.');
    } on SocketException {
      throw SocketFailure('No Internet connection!');
    }
  }
}
