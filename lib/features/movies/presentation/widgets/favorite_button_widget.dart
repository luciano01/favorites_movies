import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final Movie movie;
  final void Function()? onPressed;
  const FavoriteButtonWidget({
    Key? key,
    required this.movie,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
        ),
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            constraints: const BoxConstraints(),
            icon: Icon(
              movie.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: AppColors.accent,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
