import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/favorites_bloc.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/search_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _bloc = GetIt.instance.get<FavoritesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: _buildFavoritesList(),
        ),
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ValueListenableBuilder<Box<Movie>>(
      valueListenable: Hive.box<Movie>('movies').listenable(),
      builder: (context, box, _) {
        if (box.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.favorite_outline,
                  color: AppColors.accent,
                  size: 72,
                ),
                SizedBox(height: 10),
                Text(
                  'Oops!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'You don\'t have favorite movies.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            final movie = box.getAt(index) as Movie;

            return SearchListItemWidget(
              movie: movie,
              onTap: () {},
              onPressed: () {
                _bloc.delete(id: movie.id!);
              },
            );
          },
        );
      },
    );
  }
}
