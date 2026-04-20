import 'package:tasky/core/imports.dart';

abstract class TasksLocalDatasource {
  Future<void> addTask(TaskModel task);

  Future<void> deleteTask(int? isarId);

  Future<void> updateTask(TaskModel task);

  Future<List<TaskModel>> getTasks();

  Future<void> deleteAllTasks();
}

// class TasksHiveDatasource implements TasksLocalDatasource {
//   final Box<TaskModel> box;

//   TasksHiveDatasource(this.box);

//   @override
//   Future<void> addTask(TaskModel task) async {
//     try {
//       await box.put(task.id, task);
//     } catch (e) {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<void> deleteTask(String id) async {
//     try {
//       await box.delete(id);
//     } catch (e) {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<List<TaskModel>> getTasks() async {
//     try {
//       final tasksList = box.values.toList(growable: false).reversed.toList();
//       return tasksList;
//     } catch (e) {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<void> updateTask(TaskModel task) async {
//     try {
//       await box.put(task.id, task);
//     } catch (e) {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<void> deleteAllTasks() async {
//     try {
//       await box.clear();
//     } catch (e) {
//       throw CacheException();
//     }
//   }
// }

class TasksIsarDatasource implements TasksLocalDatasource {
  final Isar isar;

  TasksIsarDatasource(this.isar);

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await isar.writeTxn(() => isar.taskModels.put(task));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    try {
      await isar.writeTxn(() => isar.taskModels.clear());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteTask(int? isarId) async {
    try {
      await isar.writeTxn(() => isar.taskModels.delete(isarId!));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<TaskModel>> getTasks() {
    try {
      return isar.taskModels.where().findAll();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await isar.writeTxn(() => isar.taskModels.put(task));
    } catch (e) {
      throw CacheException();
    }
  }
}
