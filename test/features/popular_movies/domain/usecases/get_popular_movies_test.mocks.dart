// Mocks generated by Mockito 5.0.16 from annotations
// in favorites_movies/test/features/popular_movies/domain/usecases/get_popular_movies_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:favorites_movies/core/error/failures.dart' as _i5;
import 'package:favorites_movies/features/movies/domain/entities/movie.dart'
    as _i6;
import 'package:favorites_movies/features/movies/domain/repositories/movies_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [MoviesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRepository extends _i1.Mock implements _i3.MoviesRepository {
  MockMoviesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Movie>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  String toString() => super.toString();
}