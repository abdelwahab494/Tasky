import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

abstract class UserRepo {
  Future<Either<Failure, Unit>> saveUser(UserEntity user);

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, Unit>> login(String username);

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, Unit>> deleteUser(int userId);

  Future<Either<Failure, String?>> pickImage(ImageSource source);
}
