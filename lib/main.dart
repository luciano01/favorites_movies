import 'package:favorites_movies/app_widget.dart';
import 'package:favorites_movies/features/movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter<Movie>(MovieAdapter());
  await Hive.openBox<Movie>('movies');
  runApp(const AppWidget());
}
