import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/core/utils/app_text_styles.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/controller/bottom_navigation_controller.dart';
import 'package:favorites_movies/features/movies/presentation/pages/favorites_page.dart';
import 'package:favorites_movies/features/movies/presentation/pages/movies_page.dart';
import 'package:favorites_movies/features/movies/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late BottomNavigationController _bottomNavigationController;

  @override
  void initState() {
    _bottomNavigationController = BottomNavigationController();

    super.initState();
  }

  @override
  void dispose() {
    _bottomNavigationController.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: StreamBuilder<NavBarItem>(
            stream: _bottomNavigationController.page,
            builder: (context, snapshot) {
              var index = snapshot.data?.index ?? 0;
              var title = '';
              switch (index) {
                case 0:
                  title = 'Popular';
                  break;
                case 1:
                  title = 'Search';
                  break;
                case 2:
                  title = 'Favorites';
                  break;
                default:
                  title = '';
                  break;
              }
              return Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: AppTextStyles.textFavoritesStyle,
                    ),
                    const TextSpan(
                      text: 'Movies',
                      style: AppTextStyles.textMoviesStyle,
                    ),
                  ],
                ),
              );
            }),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: StreamBuilder<NavBarItem>(
        stream: _bottomNavigationController.page,
        initialData: _bottomNavigationController.defaultPage,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            currentIndex: snapshot.data?.index ?? 0,
            onTap: _bottomNavigationController.getPage,
            showUnselectedLabels: false,
            backgroundColor: AppColors.background,
            selectedItemColor: AppColors.accent,
            unselectedItemColor: AppColors.unselectedItemColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Movies',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
          );
        },
      ),
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavigationController.page,
        initialData: _bottomNavigationController.defaultPage,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.movie:
              return const MoviesPage();
            case NavBarItem.search:
              return const SearchPage();
            case NavBarItem.favorites:
              return const FavoritesPage();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
