import 'package:tasky/core/imports.dart';

abstract class TasksLocalDatasource {
  Future<void> addTask(TaskModel task);

  Future<void> deleteTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<List<TaskModel>> getTasks();

  Future<void> deleteAllTasks();
}

class TasksHiveDatasource extends TasksLocalDatasource {
  final Box<TaskModel> box;

  TasksHiveDatasource(this.box);

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await box.add(task);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    try {
      await task.delete();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      return box.values.toList(growable: false).reversed.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await task.save();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    try {
      await box.clear();
    } catch (e) {
      throw CacheException();
    }
  }
}
