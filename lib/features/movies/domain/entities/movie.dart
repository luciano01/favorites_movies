import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
// ignore: must_be_immutable
class Movie extends Equatable {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String releaseDate;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final String overview;

  @HiveField(5)
  final List<int> genreIds;

  @HiveField(6)
  final bool isFavorite;

  Movie({
    this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.overview,
    required this.genreIds,
    required this.isFavorite,
  });

  Movie copy({
    int? id,
    String? title,
    String? releaseDate,
    String? posterPath,
    String? overview,
    List<int>? genreIds,
    bool? isFavorite,
  }) =>
      Movie(
        id: id ?? this.id,
        title: title ?? this.title,
        releaseDate: releaseDate ?? this.releaseDate,
        posterPath: posterPath ?? this.posterPath,
        overview: overview ?? this.overview,
        genreIds: genreIds ?? this.genreIds,
        isFavorite: isFavorite ?? this.isFavorite,
      );

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
