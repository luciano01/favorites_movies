import 'package:favorites_movies/features/movies/domain/entities/movie.dart';

// ignore: must_be_immutable
class MovieModel extends Movie {
  MovieModel({
    int? id,
    required String title,
    required String releaseDate,
    required String posterPath,
    required String overview,
    required List<int> genreIds,
    required bool isFavorite,
  }) : super(
          id: id,
          title: title,
          releaseDate: releaseDate,
          posterPath: posterPath,
          overview: overview,
          genreIds: genreIds,
          isFavorite: isFavorite,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      releaseDate: json['release_date'] ?? 'No Release Date',
      posterPath: json['poster_path'] ?? '/mEtyZBbVl0sx0y1blYuVDgeNLkr.jpg',
      overview: json['overview'] ?? 'No Overview',
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
      'overview': overview,
      'genre_ids': genreIds,
      'isFavorite': isFavorite,
    };
  }

  static List<MovieModel> fromJsonList(List list) {
    return list.map((value) => MovieModel.fromJson(value)).toList();
  }
}
