import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
