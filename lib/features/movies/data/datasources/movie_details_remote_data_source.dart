import 'dart:convert';

import 'package:favorites_movies/core/error/exceptions.dart';
import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/models/detail_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieDetailsRemoteDataSource {
  Future<List<DetailModel>> getMovieDetails({required int id});
}

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final http.Client client;
  final NetworkInfo network;

  MovieDetailsRemoteDataSourceImpl({
    required this.client,
    required this.network,
  });

  @override
  Future<List<DetailModel>> getMovieDetails({required int id}) async {
    if (await network.isConnected) {
      final response = await client.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/$id?api_key=aec430914e97e1e5105c8480777cda9a&language=en-US',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return DetailModel.fromJsonList(body["results"]);
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
