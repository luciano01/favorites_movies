import 'package:favorites_movies/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:favorites_movies/features/movies/domain/repositories/movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC or MobX Store
  // sl.registerFactory();

  // Use cases
  sl.registerLazySingleton(() => GetPopularMovies(repository: sl()));

  // Repository
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      remote: sl(),
      network: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(client: sl()),
  );

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
