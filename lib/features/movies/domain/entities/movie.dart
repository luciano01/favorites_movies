import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String releaseDate;
  final String posterPath;
  final String overview;
  final List<int> genreIds;
  final bool isFavorite;

  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.overview,
    required this.genreIds,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        releaseDate,
        posterPath,
        overview,
        genreIds,
      ];
}
