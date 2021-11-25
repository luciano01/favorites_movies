import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class HttpFailure extends Failure {
  final String message;

  HttpFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LocalFailure extends Failure {
  final String message;

  LocalFailure(this.message);

  @override
  List<Object?> get props => [message];
}
