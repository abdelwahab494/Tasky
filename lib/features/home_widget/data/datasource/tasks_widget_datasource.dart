import 'package:tasky/core/imports.dart';

abstract class TasksWidgetDatasource {
  Future<void> syncTasksToWidget(List<TaskModel> tasks);
}

@LazySingleton(as: TasksWidgetDatasource, env: [Env.prod])
class TasksWidgetDatasourceImpl implements TasksWidgetDatasource {
  final Isar isar;

  const TasksWidgetDatasourceImpl(this.isar);

  @override
  Future<void> syncTasksToWidget(List<TaskModel> tasks) async {
    try {
      final widgetText = tasks.map((e) => e.taskName).join(",");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('tasks', widgetText);

      await WidgetHelper.channel.invokeMethod('updateWidget');
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      throw WidgetException();
    }
  }
}
