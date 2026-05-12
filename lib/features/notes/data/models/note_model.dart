import 'package:tasky/core/imports.dart';

part 'note_model.g.dart';

@Collection()
class NoteModel {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String title;
  late String body;
  late DateTime createdAt;

  final user = IsarLink<UserModel>();

  NoteModel();

  factory NoteModel.fromEntity(NoteEntity note) {
    return NoteModel()
      ..isarId = note.isarId ?? Isar.autoIncrement
      ..id = note.id
      ..title = note.title
      ..body = note.body
      ..createdAt = note.createdAt;
  }

  NoteEntity toEntity() {
    return NoteEntity(
      isarId: isarId,
      id: id,
      title: title,
      body: body,
      createdAt: createdAt,
    );
  }
}
