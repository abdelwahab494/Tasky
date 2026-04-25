import 'package:tasky/core/imports.dart';

class IsarHelper {
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([TaskModelSchema, NoteModelSchema, UserModelSchema], directory: dir.path);
  }
}
