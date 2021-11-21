import 'package:favorites_movies/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(
        internetConnectionChecker: mockInternetConnectionChecker);
  });

  test('Should forward the call to InternetConnectionChecker.hasConnection.',
      () async {
    // arrange
    final tHasConnectionFuture = Future.value(true);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => tHasConnectionFuture);
    // act
    final result = networkInfoImpl.isConnected;
    // assert
    verify(mockInternetConnectionChecker.hasConnection);
    expect(result, tHasConnectionFuture);
  });
}
