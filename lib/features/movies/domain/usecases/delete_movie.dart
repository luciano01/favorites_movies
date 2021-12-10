import 'package:favorites_movies/features/movies/domain/repositories/delete_movie_repository.dart';

class DeleteMovie implements DeleteMovieRepository {
  final DeleteMovieRepository repository;

  DeleteMovie({required this.repository});

  @override
  Future<void> delete({required int id}) async {
    await repository.delete(id: id);
  }
}
