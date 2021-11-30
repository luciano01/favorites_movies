import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/grid_view_widget.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final _bloc = GetIt.instance.get<MoviesBloc>();

  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _bloc.getPopularMovies();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: _bloc.outPopularMovies,
            builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
              List<Movie>? listOfPopularMovies = snapshot.data;
              dynamic error = snapshot.error;
              if (error != null) {
                return Text(error.toString());
              } else if (listOfPopularMovies == null) {
                return const LoadingWidget();
              } else if (snapshot.hasData) {
                return GridViewWidget(
                  listOfPopularMovies: listOfPopularMovies,
                  scrollController: _scrollController,
                );
              }
              return const LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
