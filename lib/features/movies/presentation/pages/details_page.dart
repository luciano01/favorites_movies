import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/core/utils/base_url.dart';
import 'package:favorites_movies/features/movies/domain/entities/detail.dart';
import 'package:favorites_movies/features/movies/domain/entities/genre.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/details_bloc.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _bloc = GetIt.instance.get<DetailsBloc>();

  @override
  void initState() {
    var id = Get.arguments;
    _bloc.getMovieDetails(id: id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: StreamBuilder<Detail>(
          stream: _bloc.movieDetailsStream,
          builder: (context, snapshot) {
            Detail? movie = snapshot.data;

            if (movie == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LoadingWidget(),
                    SizedBox(height: 10),
                    Text(
                      'Loading Movie Details...',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          BaseUrl.urlPosterPath(movie.backdropPath),
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.accent,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.originalTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      height: 25,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: movie.genres.length,
                        itemBuilder: (context, index) {
                          Genre genre = movie.genres[index];
                          bool isLast =
                              movie.genres[index] == movie.genres.last;
                          return Text(
                            isLast ? ' ${genre.name}' : '${genre.name}, ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: AppColors.textFieldTextDisable,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            movie.releaseDate,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textFieldTextDisable,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: AppColors.textFieldTextDisable,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${movie.runtime} min',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textFieldTextDisable,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.voteAverage.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: const [
                          Icon(Icons.star, color: AppColors.accent),
                          Icon(Icons.star, color: AppColors.accent),
                          Icon(Icons.star, color: AppColors.accent),
                          Icon(Icons.star_half, color: AppColors.accent),
                          Icon(Icons.star_outline, color: AppColors.accent),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overview',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie.overview,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
