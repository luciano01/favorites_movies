import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required int id,
    required String title,
    required String releaseDate,
    required String posterPath,
    required List<int> genreIds,
    required bool isFavorite,
  }) : super(
          id: id,
          title: title,
          releaseDate: releaseDate,
          posterPath: posterPath,
          genreIds: genreIds,
          isFavorite: isFavorite,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      genreIds: List<int>.from(json['genre_ids'] ?? const []),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'poster_path': posterPath,
      'genre_ids': genreIds,
      'isFavorite': isFavorite,
    };
  }

  static List<MovieModel> fromJsonList(List list) {
    return list.map((value) => MovieModel.fromJson(value)).toList();
  }
}
