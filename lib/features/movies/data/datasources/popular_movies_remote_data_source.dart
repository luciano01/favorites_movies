import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class PopularMoviesRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class PopularMoviesRemoteDataSourceImpl
    implements PopularMoviesRemoteDataSource {
  final http.Client client;

  PopularMoviesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse(BaseUrl.urlPopularMovies),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return MovieModel.fromJsonList(body["results"]);
    } else if (response.statusCode == 404) {
      throw HttpException();
    } else {
      throw ServerException();
    }
  }
}
