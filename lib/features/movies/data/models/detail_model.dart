import 'package:favorites_movies/features/movies/domain/entities/detail.dart';
import 'package:favorites_movies/features/movies/domain/entities/genre.dart';

class DetailModel extends Detail {
  const DetailModel({
    required int id,
    required String originalTitle,
    required String backdropPath,
    required List<Genre> genres,
    required String releaseDate,
    required int runtime,
    required double voteAverage,
    required String overview,
  }) : super(
          id: id,
          originalTitle: originalTitle,
          backdropPath: backdropPath,
          genres: genres,
          releaseDate: releaseDate,
          runtime: runtime,
          voteAverage: voteAverage,
          overview: overview,
        );

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'] ?? 0,
      originalTitle: json['original_title'] ?? 'No Original Title',
      backdropPath: json['backdrop_path'] ?? 'No Backdrop Path',
      genres: List<Genre>.from(json['genres'] ?? const []),
      releaseDate: json['release_date'] ?? 'No Release Date',
      runtime: json['runtime'] ?? 'No Runtime',
      voteAverage: json['vote_average'] ?? 0.0,
      overview: json['overview'] ?? 'No Overview',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_title': originalTitle,
      'backdrop_path': backdropPath,
      'genres': genres,
      'release_date': releaseDate,
      'runtime': runtime,
      'vote_average': voteAverage,
      'overview': overview,
    };
  }

  static List<DetailModel> fromJsonList(List list) {
    return list.map((value) => DetailModel.fromJson(value)).toList();
  }
}
