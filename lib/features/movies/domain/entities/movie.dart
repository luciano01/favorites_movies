import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String releaseDate;
  final String posterPath;
  final List<int> genreIds;

  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.genreIds,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        releaseDate,
        posterPath,
        genreIds,
      ];
}
