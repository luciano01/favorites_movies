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
  Future<Detail> getMovieDetails({required int id}) async {
    try {
      final remoteMovieDetails = await remote.getMovieDetails(id: id);
      return remoteMovieDetails;
    } on ServerException {
      throw ServerFailure('Internal Server Error.');
    } on HttpException {
      throw HttpFailure('Couldn\'t find the Movie Details.');
    } on SocketException {
      throw SocketFailure('No Internet connection!');
    }
  }
}
