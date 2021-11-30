import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/datasources/search_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/repositories/popular_movies_repository_impl.dart';
import 'package:favorites_movies/features/movies/data/repositories/search_movies_repository_impl.dart';
import 'package:favorites_movies/features/movies/domain/repositories/popular_movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/repositories/search_movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:favorites_movies/features/movies/domain/usecases/search_movies.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => MoviesBloc(
      usecase: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchBloc(
      usecase: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(
    () => GetPopularMovies(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SearchMovies(
      repository: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<PopularMoviesRepository>(
    () => PopularMoviesRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<SearchMoviesRepository>(
    () => SearchMoviesRepositoryImpl(
      remote: sl(),
    ),
  );

  // DataSources
  sl.registerLazySingleton<PopularMoviesRemoteDataSource>(
    () => PopularMoviesRemoteDataSourceImpl(
      client: sl(),
      network: sl(),
    ),
  );
  sl.registerLazySingleton<SearchMoviesRemoteDataSource>(
    () => SearchMoviesRemoteDataSourceImpl(
      client: sl(),
      network: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      internetConnectionChecker: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
