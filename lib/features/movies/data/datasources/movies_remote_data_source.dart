import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;

  MoviesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse(BaseUrl.urlPopularMovies),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return MovieModel.fromJsonList(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
