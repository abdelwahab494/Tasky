import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class LoginUsecase extends UseCase<Unit, LoginParams> {
  final UserRepo repo;

  LoginUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(LoginParams params) {
    return repo.login(params.name);
  }
}

class LoginParams {
  final String name;

  LoginParams(this.name);
}
