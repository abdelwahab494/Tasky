import 'package:tasky/core/imports.dart';

class HiveHelper {
  static const String tasksBoxName = "tasks";

  static Box<TaskModel> get tasks => Hive.box<TaskModel>(tasksBoxName);

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    await Hive.openBox<TaskModel>(tasksBoxName);
  }
}
