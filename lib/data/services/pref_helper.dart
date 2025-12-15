import 'package:tasky/core/imports.dart';

class PrefHelper {
  static final String nameKey = "name key";
  static final String quoteKey = "quote key";
  static final String tasksListKey = "tasksList";
  static final String themeKey = "isDark";
  static final String profileImageKey = "profile image";
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //* Name
  static Future<void> saveName(String userName) async {
    await _prefs.setString(nameKey, userName);
  }

  static Future<String?> getName() async {
    return _prefs.getString(nameKey);
  }

  static Future<void> clearName() async {
    await _prefs.remove(nameKey);
  }

  //* Quote
  static Future<void> saveQuote(String quote) async {
    await _prefs.setString(quoteKey, quote);
  }

  static Future<String?> getQuote() async {
    return _prefs.getString(quoteKey);
  }

  static Future<void> clearQuote() async {
    await _prefs.remove(quoteKey);
  }

  //* Task List
  static Future<void> updateTasksList(List<TaskModel> tasksList) async {
    final updatedList = tasksList.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(tasksListKey, updatedList);
  }

  static Future<List<TaskModel>> getTasksList() async {
    final List<String> tasksListEncoded =
        _prefs.getStringList(tasksListKey) ?? [];
    return tasksListEncoded
        .map((e) => TaskModel.fromJson(jsonDecode(e)))
        .toList();
  }

  static Future<void> clearTasksList() async {
    await _prefs.remove(tasksListKey);
  }

  //* Add New Task
  static Future<void> addNewTask(TaskModel task) async {
    final List<TaskModel> tasksList = await getTasksList();
    tasksList.add(task);
    await updateTasksList(tasksList);
  }

  //* Theme
  static Future<void> saveTheme(bool value) async {
    await _prefs.setBool(themeKey, value);
  }

  static Future<bool?> getTheme() async {
    return _prefs.getBool(themeKey);
  }

  //* Profile Image
  static Future<void> saveProfileImage(String pickedImage) async {
    await _prefs.setString(profileImageKey, pickedImage);
  }

  static Future<String?> getProfileImage() async {
    return _prefs.getString(profileImageKey);
  }

  static Future<void> clearProfileImage() async {
    await _prefs.remove(profileImageKey);
  }
}
