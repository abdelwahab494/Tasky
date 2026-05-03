import 'package:tasky/core/imports.dart';

class SessionHelper {
  // UserModel? _currentUser;
  final UserRepo userRepo;
  final Isar isar;

  SessionHelper(this.userRepo, this.isar);

  Future<UserModel> getCurrentUser() async {
    // if (_currentUser != null) return _currentUser!;

    final result = await userRepo.getCurrentUser();

    return result.fold((failure) => throw CacheException(), (userEntity) async {
      if (userEntity == null || userEntity.isarId == null) throw CacheException();

      final user = await isar.userModels.get(userEntity.isarId!);

      if (user == null) throw CacheException();

      // _currentUser = user;
      return user;
    });
  }

  // void setUser(UserModel user) {
  //   _currentUser = user;
  // }

  // void clear() {
  //   _currentUser = null;
  // }
}
