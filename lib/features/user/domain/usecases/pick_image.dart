import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class PickImageUsecase extends UseCase<String?, PickImageParams> {
  final UserRepo repo;

  PickImageUsecase(this.repo);

  @override
  Future<Either<Failure, String?>> call(PickImageParams params) {
    return repo.pickImage(params.imageSource);
  }
}

class PickImageParams {
  final ImageSource imageSource;

  PickImageParams({required this.imageSource});
}
