import 'package:favorites_movies/features/movies/presentation/bloc/controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      bottomNavigationBar: StreamBuilder<NavBarItem>(
        stream: _bottomNavigationController.page,
        initialData: _bottomNavigationController.defaultPage,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data?.index ?? 0,
            onTap: _bottomNavigationController.getPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Movies',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
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
              return const Center(
                child: Text('Movies'),
              );
            case NavBarItem.favorites:
              return const Center(
                child: Text('Favorites'),
              );
            case NavBarItem.settings:
              return const Center(
                child: Text('Settings'),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
