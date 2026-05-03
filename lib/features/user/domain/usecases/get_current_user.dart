import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class GetCurrentUserUsecase extends UseCase<UserEntity?, NoParams> {
  final UserRepo repo;

  GetCurrentUserUsecase(this.repo);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return repo.getCurrentUser();
  }
}
