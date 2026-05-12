import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton(as: UserRepo, env: [Env.prod])
class UserRepoImpl implements UserRepo {
  final UserLocalDatasource source;

  UserRepoImpl(this.source);

  @override
  Future<Either<Failure, Unit>> saveUser(UserEntity user) async {
    try {
      final UserModel model = UserModel.fromEntity(user);
      await source.saveUser(model);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> login(String username) async {
    try {
      await source.loginUser(username);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await source.getCurrentUser();
      return Right(user?.toEntity());
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int userId) async {
    try {
      await source.deleteUser(userId);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await source.getAllUsers();
      return Right(users.map((e) => e.toEntity()).toList());
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await source.logout();
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> pickImage(ImageSource imageSource) async {
    try {
      final path = await source.pickImage(imageSource);
      return Right(path);
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}
