import 'package:favorites_movies/features/movies/domain/entities/genre.dart';

class GenreModel extends Genre {
  const GenreModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
