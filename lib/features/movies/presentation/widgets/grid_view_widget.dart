import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/list_item_widget.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridViewWidget extends StatelessWidget {
  final List<Movie> listOfPopularMovies;
  final ScrollController scrollController;
  const GridViewWidget({
    Key? key,
    required this.listOfPopularMovies,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 230,
        ),
        controller: scrollController,
        itemCount: listOfPopularMovies.length + 1,
        itemBuilder: (context, index) {
          if (index == listOfPopularMovies.length) {
            return const LoadingWidget();
          } else {
            return ListItemWidget(
              movie: listOfPopularMovies[index],
              onTap: () {
                Get.toNamed(
                  '/details',
                  arguments: listOfPopularMovies[index].id,
                );
              },
              onPressed: () {},
            );
          }
        },
      ),
    );
  }
}
