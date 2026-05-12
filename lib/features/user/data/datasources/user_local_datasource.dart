import 'package:tasky/core/imports.dart';

abstract class UserLocalDatasource {
  Future<void> saveUser(UserModel user);

  Future<UserModel?> getCurrentUser();

  Future<void> loginUser(String username);

  Future<void> logout();

  Future<void> deleteUser(int userId);

  Future<List<UserModel>> getAllUsers();

  Future<String?> pickImage(ImageSource imageSource);
}

class UserIsarDatasource implements UserLocalDatasource {
  final Isar isar;

  UserIsarDatasource(this.isar);

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await isar.writeTxn(() async {
        await isar.userModels.put(user);
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      return await isar.userModels.filter().isLoggedEqualTo(true).findFirst();
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> loginUser(String username) async {
    try {
      await isar.writeTxn(() async {
        final allUsers = await isar.userModels.where().findAll();
        for (final user in allUsers) {
          user.isLogged = false;
        }
        await isar.userModels.putAll(allUsers);

        var user = await isar.userModels
            .where()
            .nameEqualTo(username)
            .findFirst();

        if (user == null) {
          user = UserModel()
            ..name = username
            ..isLogged = true;

          await isar.userModels.put(user);
        } else {
          user.isLogged = true;
          await isar.userModels.put(user);
        }
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await isar.writeTxn(() async {
        final users = await isar.userModels.where().findAll();
        for (final user in users) {
          user.isLogged = false;
        }
        await isar.userModels.putAll(users);
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> deleteUser(int userId) async {
    try {
      await isar.writeTxn(() async {
        final user = await isar.userModels.get(userId);
        if (user == null) throw CacheException();

        await user.notes.load();
        await user.tasks.load();

        final noteIds = user.notes.map((e) => e.isarId).toList();
        final taskIds = user.tasks.map((e) => e.isarId).toList();

        await isar.noteModels.deleteAll(noteIds);
        await isar.taskModels.deleteAll(taskIds);

        await isar.userModels.delete(userId);
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      return await isar.userModels.where().findAll();
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<String?> pickImage(ImageSource imageSource) async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: imageSource,
    );  
    if (pickedImage == null) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(
      pickedImage.path,
    ).copy("${appDir.path}/${pickedImage.name}");

    return newFile.path;
  }
}
