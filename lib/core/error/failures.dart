import 'package:tasky/core/imports.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class UnexpectedFailure extends Failure {}

class CacheFailure extends Failure {}

class HiveFailure extends Failure {}
