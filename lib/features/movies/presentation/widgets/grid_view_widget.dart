import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/list_item_widget.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  final List<Movie> listOfMovies;
  const GridViewWidget({
    Key? key,
    required this.listOfMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 230,
        ),
        itemCount: listOfMovies.length,
        itemBuilder: (context, index) {
          Movie movie = listOfMovies[index];
          return ListItemWidget(
            movie: movie,
            onTap: () {},
            onPressed: () {},
          );
        },
      ),
    );
  }
}
