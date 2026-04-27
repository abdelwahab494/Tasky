import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class SaveUserUsecase extends UseCase<Unit, SaveUserParams> {
  final UserRepo repo;

  SaveUserUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(SaveUserParams params) {
    return repo.saveUser(params.user);
  }
}

class SaveUserParams {
  final UserEntity user;

  SaveUserParams({required this.user});

  SaveUserParams copyWith({UserEntity? user}) {
    return SaveUserParams(user: user ?? this.user);
  }
}
