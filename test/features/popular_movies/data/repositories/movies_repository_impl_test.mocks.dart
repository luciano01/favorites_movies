// Mocks generated by Mockito 5.0.16 from annotations
// in favorites_movies/test/features/popular_movies/data/repositories/movies_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:favorites_movies/core/network/network_info.dart' as _i5;
import 'package:favorites_movies/features/movies/data/datasources/popular_movies_remote_data_source.dart'
    as _i2;
import 'package:favorites_movies/features/movies/data/models/movie_model.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [PopularMoviesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularMoviesRemoteDataSource extends _i1.Mock
    implements _i2.PopularMoviesRemoteDataSource {
  MockPopularMoviesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]))
      as _i3.Future<List<_i4.MovieModel>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i5.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}
