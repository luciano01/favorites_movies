import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/search_bloc.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/loading_widget.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/search_field_widget.dart';
import 'package:favorites_movies/features/movies/presentation/widgets/search_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _bloc = GetIt.instance.get<SearchBloc>();

  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchFieldWidget(
                    textEditingController: _bloc.textEditingController,
                    focusNode: _focusNode,
                    onPressedTextButton: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _bloc.searchMovieByName(
                        _bloc.textEditingController.text,
                      );
                    },
                    onPressedSuffixIcon: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _bloc.textEditingController.clear();
                      _bloc.searchMovieByName(
                        _bloc.textEditingController.text,
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: _bloc.moviesStream,
                builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
                  List<Movie>? listOfSearchMovies = snapshot.data;
                  dynamic error = snapshot.error;
                  if (error != null) {
                    return Text(error.toString());
                  } else if (listOfSearchMovies == null) {
                    return const LoadingWidget();
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: listOfSearchMovies.length,
                        itemBuilder: (context, index) {
                          return SearchListItemWidget(
                            movie: listOfSearchMovies[index],
                            onTap: () {},
                            onPressed: () {},
                          );
                        },
                      ),
                    );
                  }
                  return const LoadingWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
