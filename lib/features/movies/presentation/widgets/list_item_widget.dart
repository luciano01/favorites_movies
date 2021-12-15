import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/favorite_button_widget.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/poster_widget.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final Movie movie;
  final void Function()? onTap;
  final void Function()? onPressed;
  const ListItemWidget({
    Key? key,
    required this.movie,
    required this.onTap,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      semanticContainer: true,
      margin: const EdgeInsets.all(5),
      child: InkWell(
        child: Stack(
          children: [
            PosterWidget(posterPath: movie.posterPath),
            FavoriteButtonWidget(
              movie: movie,
              onPressed: onPressed,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
