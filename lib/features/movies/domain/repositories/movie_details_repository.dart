import 'package:favorites_movies/features/movies/domain/entities/detail.dart';

abstract class MovieDetailsRepository {
  Future<List<Detail>> getMovieDetails({required int id});
}
