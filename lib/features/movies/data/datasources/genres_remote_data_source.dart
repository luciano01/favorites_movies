import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:favorites_movies/features/movies/data/models/genre_model.dart';
import 'package:http/http.dart' as http;

abstract class GenresRemoteDataSource {
  Future<List<GenreModel>> getGenres();
}

class GenresRemoteDataSourceImpl implements GenresRemoteDataSource {
  final http.Client client;

  GenresRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GenreModel>> getGenres() async {
    final response = await client.get(
      Uri.parse(BaseUrl.urlGenres),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GenreModel.fromJsonList(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
