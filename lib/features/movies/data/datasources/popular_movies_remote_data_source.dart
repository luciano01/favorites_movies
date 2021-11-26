import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class PopularMoviesRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies(int page);
}

class PopularMoviesRemoteDataSourceImpl
    implements PopularMoviesRemoteDataSource {
  final http.Client client;
  final NetworkInfo network;

  PopularMoviesRemoteDataSourceImpl({
    required this.client,
    required this.network,
  });

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    if (await network.isConnected) {
      final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=aec430914e97e1e5105c8480777cda9a&language=en-US&page=$page'),
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
    } else {
      throw SocketException();
    }
  }
}
