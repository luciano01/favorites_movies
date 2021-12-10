import 'dart:async';

import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/create_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/delete_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/update_movie.dart';
import 'package:get_it/get_it.dart';

class FavoritesBloc extends Disposable {
  final CreateMovie createUsecase;
  final UpdateMovie updateUsecase;
  final DeleteMovie deleteUsecase;

  FavoritesBloc({
    required this.createUsecase,
    required this.updateUsecase,
    required this.deleteUsecase,
  });

  create({required Movie movie}) async {
    var movieToCreate = movie.copy(isFavorite: !movie.isFavorite);
    await createUsecase.create(movie: movieToCreate);
  }

  update({required int id, required Movie movie}) async {
    var movieToUpdate = movie.copy(isFavorite: !movie.isFavorite);
    await updateUsecase.update(id: id, movie: movieToUpdate);
  }

  delete({required int id}) async {
    await deleteUsecase.delete(id: id);
  }

  @override
  FutureOr onDispose() {
    throw UnimplementedError();
  }
}
