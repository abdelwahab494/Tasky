import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class SettingsRepoImpl extends SettingsRepo {
  final SettingsDatasource source;

  SettingsRepoImpl(this.source);

  @override
  Future<Either<Failure, SettingsEntity>> getSettings() async {
    try {
      final SettingsModel settings = await source.getSettings();
      return Right(settings.toEntity());
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleTheme(bool value) async {
    try {
      await source.toggleTheme(value);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}
