import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class SaveUserUsecase extends UseCase<Unit, SaveUserParams> {
  final UserRepo repo;

  SaveUserUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(SaveUserParams params) {
    final UserEntity user = UserEntity(
      name: params.name,
      isLogged: true,
      lastLoggedDate: DateTime.now(),
    );
    return repo.saveUser(user);
  }
}

class SaveUserParams {
  final String name;

  SaveUserParams(this.name);
}
