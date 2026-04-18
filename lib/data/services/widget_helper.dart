import 'package:tasky/core/imports.dart';

class WidgetHelper {
  static const String tasksKey = "tasks";
  static const MethodChannel channel = MethodChannel(
    'com.example.tasky/update_widget',
  );

  static Future<void> updateAndroidWidget(String tasks) async {
    try {
      // First save data using SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(tasksKey, tasks);

      // Then notify the platform to update the widget
      await platform.invokeMethod('updateWidget');
    } catch (e) {
      null;
    }
  }

  // static Future<String> loadWidgetTasks() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String tasksString = prefs.getString('tasks') ?? '';
  //   return tasksString;
  // }
}
