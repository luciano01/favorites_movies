import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:flutter/material.dart';

class PosterWidget extends StatelessWidget {
  final String posterPath;
  const PosterWidget({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      BaseUrl.urlPosterPath(posterPath),
      height: 250,
      fit: BoxFit.fill,
    );
  }
}
