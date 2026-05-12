import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class GetSettingsUsecase extends UseCase<SettingsEntity, NoParams> {
  final SettingsRepo repo;

  GetSettingsUsecase(this.repo);

  @override
  Future<Either<Failure, SettingsEntity>> call(NoParams params) {
    return repo.getSettings();
  }
}
