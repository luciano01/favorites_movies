import 'dart:async';

import 'package:get_it/get_it.dart';

enum NavBarItem { movie, search, favorites }

class BottomNavigationController extends Disposable {
  final _controller = StreamController<NavBarItem>.broadcast();

  NavBarItem defaultPage = NavBarItem.movie;

  Stream<NavBarItem> get page => _controller.stream;

  void getPage(int index) {
    switch (index) {
      case 0:
        _controller.sink.add(NavBarItem.movie);
        break;
      case 1:
        _controller.sink.add(NavBarItem.search);
        break;
      case 2:
        _controller.sink.add(NavBarItem.favorites);
        break;
    }
  }

  @override
  void onDispose() {
    _controller.close();
  }
}
