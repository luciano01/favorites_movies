// Mocks generated by Mockito 5.0.16 from annotations
// in favorites_movies/test/features/popular_movies/domain/usecases/get_movie_details_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:favorites_movies/features/movies/domain/entities/detail.dart'
    as _i4;
import 'package:favorites_movies/features/movies/domain/repositories/movie_details_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [MovieDetailsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailsRepository extends _i1.Mock
    implements _i2.MovieDetailsRepository {
  MockMovieDetailsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Detail>> getMovieDetails({int? id}) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetails, [], {#id: id}),
              returnValue: Future<List<_i4.Detail>>.value(<_i4.Detail>[]))
          as _i3.Future<List<_i4.Detail>>);
  @override
  String toString() => super.toString();
}
