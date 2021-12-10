import 'package:favorites_movies/core/network/network_info.dart';
import 'package:favorites_movies/features/movies/data/datasources/create_movie_data_source.dart';
import 'package:favorites_movies/features/movies/data/datasources/delete_movie_data_source.dart';
import 'package:favorites_movies/features/movies/data/datasources/movie_details_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/datasources/search_movies_remote_data_source.dart';
import 'package:favorites_movies/features/movies/data/datasources/update_movie_data_source.dart';
import 'package:favorites_movies/features/movies/data/repositories/create_movie_repository_impl.dart';
import 'package:favorites_movies/features/movies/data/repositories/delete_movie_repository_impl.dart';
import 'package:favorites_movies/features/movies/data/repositories/movie_details_repository_impl.dart';
import 'package:favorites_movies/features/movies/data/repositories/popular_movies_repository_impl.dart';
import 'package:favorites_movies/features/movies/data/repositories/search_movies_repository_impl.dart';
import 'package:favorites_movies/features/movies/data/repositories/update_movie_repository_impl.dart';
import 'package:favorites_movies/features/movies/domain/repositories/create_movie_repository.dart';
import 'package:favorites_movies/features/movies/domain/repositories/delete_movie_repository.dart';
import 'package:favorites_movies/features/movies/domain/repositories/movie_details_repository.dart';
import 'package:favorites_movies/features/movies/domain/repositories/popular_movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/repositories/search_movies_repository.dart';
import 'package:favorites_movies/features/movies/domain/repositories/update_movie_repository.dart';
import 'package:favorites_movies/features/movies/domain/usecases/create_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/delete_movie.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_movie_details.dart';
import 'package:favorites_movies/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:favorites_movies/features/movies/domain/usecases/search_movies.dart';
import 'package:favorites_movies/features/movies/domain/usecases/update_movie.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/details_bloc.dart';
import 'package:favorites_movies/features/movies/presentation/bloc/favorites_bloc.dart';
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
      createUsecase: sl(),
      updateUsecase: sl(),
      deleteUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchBloc(
      usecase: sl(),
      createUsecase: sl(),
      updateUsecase: sl(),
      deleteUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => DetailsBloc(
      usecase: sl(),
    ),
  );
  sl.registerFactory(
    () => FavoritesBloc(
      createUsecase: sl(),
      updateUsecase: sl(),
      deleteUsecase: sl(),
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
  sl.registerFactory(
    () => GetMovieDetails(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => CreateMovie(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => UpdateMovie(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteMovie(
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
  sl.registerLazySingleton<MovieDetailsRepository>(
    () => MovieDetailsRepositoryImpl(
      remote: sl(),
    ),
  );
  sl.registerLazySingleton<CreateMovieRepository>(
    () => CreateMovieRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateMovieRepository>(
    () => UpdateMovieRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteMovieRepository>(
    () => DeleteMovieRepositoryImpl(
      dataSource: sl(),
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
  sl.registerLazySingleton<MovieDetailsRemoteDataSource>(
    () => MovieDetailsRemoteDataSourceImpl(
      client: sl(),
      network: sl(),
    ),
  );
  sl.registerLazySingleton<CreateMovieDataSource>(
    () => CreateMovieDataSourceImpl(),
  );
  sl.registerLazySingleton<UpdateMovieDataSource>(
    () => UpdateMovieDataSourceImpl(),
  );
  sl.registerLazySingleton<DeleteMovieDataSource>(
    () => DeleteMovieDataSourceImpl(),
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
