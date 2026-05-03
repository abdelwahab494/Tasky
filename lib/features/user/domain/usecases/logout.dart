import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class LogoutUsecase extends UseCase<Unit, NoParams> {
  final UserRepo repo;

  LogoutUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repo.logout();
  }
}
