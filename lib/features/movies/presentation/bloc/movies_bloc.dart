import 'package:dartz/dartz.dart';
import 'package:favorites_movies/core/error/failures.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'movies_event.dart';
import 'movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String serverFailureMessage = 'Server Failure';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPopularMovies usecase;

  MoviesBloc({required this.usecase}) : super(Start());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is GetPopularMoviesEvent) {
      yield Loading();
      final failureOrMovies = await usecase.getPopularMovies();
      yield* _eitherLoadedOrErrorState(failureOrMovies);
    }
  }
}

Stream<MoviesState> _eitherLoadedOrErrorState(
  Either<Failure, List<Movie>> failureOrMovies,
) async* {
  yield failureOrMovies.fold(
    (failure) => Error(message: _mapFailureToMessage(failure)),
    (movies) => Loaded(movies: movies),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    default:
      return 'Unexpected error';
  }
}
