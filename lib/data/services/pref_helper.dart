import 'package:tasky/core/imports.dart';

class PrefHelper {
  static const String nameKey = "name key";
  static const String quoteKey = "quote key";
  static const String tasksListKey = "tasksList";
  static const String themeKey = "isDark";
  static const String profileImageKey = "profile image";
  static const String notesListKey = "notesList";
  static late SharedPreferences _prefs;

  //* Initialize _prefs
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
  static Future<void> updateTasksList(List<TasksModel> tasksList) async {
    final updatedList = tasksList.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(tasksListKey, updatedList);
  }

  static Future<List<TasksModel>> getTasksList() async {
    final List<String> tasksListEncoded =
        _prefs.getStringList(tasksListKey) ?? [];
    return tasksListEncoded
        .map((e) => TasksModel.fromJson(jsonDecode(e)))
        .toList();
  }

  static Future<void> clearTasksList() async {
    await _prefs.remove(tasksListKey);
  }

  //* Add New Task
  static Future<void> addNewTask(TasksModel task) async {
    final List<TasksModel> tasksList = await getTasksList();
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

  //*Notes List
  static Future<void> updateNotesList(List<NoteModel> notesList) async {
    final updatedList = notesList.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(notesListKey, updatedList);
  }

  static Future<List<NoteModel>> getNotesList() async {
    final List<String> notesListEncoded =
        _prefs.getStringList(notesListKey) ?? [];
    return notesListEncoded
        .map((e) => NoteModel.fromJson(jsonDecode(e)))
        .toList();
  }

  static Future<void> clearNotesList() async {
    await _prefs.remove(notesListKey);
  }
}
