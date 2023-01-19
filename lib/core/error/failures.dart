import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure(this.properties);

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {
  const ServerFailure(super.properties);
}

class CacheFailure extends Failure {
  const CacheFailure(super.properties);
}
