import 'package:equatable/equatable.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

abstract class MoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class Start extends MoviesState {}

class Loading extends MoviesState {}

class Loaded extends MoviesState {
  final List<Movie> movies;

  Loaded({required this.movies});
}

class Error extends MoviesState {
  final String message;

  Error({required this.message});
}
