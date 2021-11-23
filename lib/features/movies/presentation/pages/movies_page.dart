import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/movies_event.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/movies_state.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/grid_view_widget.dart';
import 'package:favorites_movies/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.background,
          child: BlocProvider(
            create: (_) => sl<MoviesBloc>(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BlocBuilder<MoviesBloc, MoviesState>(
                builder: (context, state) {
                  if (state is Start) {
                    BlocProvider.of<MoviesBloc>(context)
                        .add(GetPopularMoviesEvent());
                    return const Center(
                      child: Text('Starting...'),
                    );
                  } else if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Loaded) {
                    List<Movie> listOfMovies = state.movies;
                    return GridViewWidget(listOfMovies: listOfMovies);
                  } else if (state is Error) {
                    return const Center(
                      child: Text('Error...'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
