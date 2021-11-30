import 'package:equatable/equatable.dart';
import 'package:favorites_movies/features/movies/domain/entities/genre.dart';

class Detail extends Equatable {
  final int id;
  final String originalTitle;
  final String backdropPath;
  final List<Genre> genres;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final String overview;

  const Detail({
    required this.id,
    required this.originalTitle,
    required this.backdropPath,
    required this.genres,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.overview,
  });

  @override
  List<Object?> get props => [
        id,
        originalTitle,
        backdropPath,
        genres,
        releaseDate,
        runtime,
        voteAverage,
        overview,
      ];
}
