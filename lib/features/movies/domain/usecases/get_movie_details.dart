import 'package:favorites_movies/features/movies/domain/entities/detail.dart';
import 'package:favorites_movies/features/movies/domain/repositories/movie_details_repository.dart';

class GetMovieDetails implements MovieDetailsRepository {
  final MovieDetailsRepository repository;

  GetMovieDetails({required this.repository});

  @override
  Future<Detail> getMovieDetails({required int id}) async {
    return await repository.getMovieDetails(id: id);
  }
}
