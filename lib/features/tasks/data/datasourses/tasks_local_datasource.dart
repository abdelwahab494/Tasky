import 'package:tasky/core/imports.dart';

abstract class TasksLocalDatasource {
  Future<void> addTask(UserModel user, TaskModel task);

  Future<void> deleteTask(int? isarId);

  Future<void> updateTask(UserModel user, TaskModel task);

  Future<List<TaskModel>> getTasks(UserModel user);

  Future<void> deleteAllTasks(UserModel user);
}

class TasksIsarDatasource implements TasksLocalDatasource {
  final Isar isar;

  TasksIsarDatasource(this.isar);

  @override
  Future<void> addTask(UserModel user, TaskModel task) async {
    try {
      final alreadyExists = user.tasks.contains(task);
      await isar.writeTxn(() async {
        await isar.taskModels.put(task);

        task.user.value = user;
        await task.user.save();

        if (!alreadyExists) {
          user.tasks.add(task);
        }
        await user.tasks.save();
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllTasks(UserModel user) async {
    try {
      await isar.writeTxn(() async {
        await user.tasks.load();
        final ids = user.tasks.map((e) => e.isarId).toList();

        await isar.taskModels.deleteAll(ids);

        user.tasks.clear();
        await user.tasks.save();
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> deleteTask(int? isarId) async {
    try {
      if (isarId != null) {
        await isar.writeTxn(() async {
          await isar.taskModels.delete(isarId);
        });
      }
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<List<TaskModel>> getTasks(UserModel user) async {
    try {
      await user.tasks.load();
      return user.tasks.toList();
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> updateTask(UserModel user, TaskModel task) async {
    try {
      await isar.writeTxn(() async {
        await isar.taskModels.put(task);

        task.user.value = user;
        await task.user.save();
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw CacheException();
    }
  }
}
