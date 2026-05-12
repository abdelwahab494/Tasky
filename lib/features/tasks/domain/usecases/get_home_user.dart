import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class GetHomeUserUsecase extends UseCase<HomeUserEntity, NoParams> {
  final TasksRepo repo;

  GetHomeUserUsecase(this.repo);

  @override
  Future<Either<Failure, HomeUserEntity>> call(NoParams params) {
    return repo.getCurrentUser();
  }
}
