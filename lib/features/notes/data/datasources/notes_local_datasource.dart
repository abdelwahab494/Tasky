import 'package:tasky/core/imports.dart';

abstract class NotesLocalDatasource {
  Future<void> addNote(UserModel user, NoteModel note);

  Future<void> updateNote(UserModel user, NoteModel note);

  Future<void> deleteNote(List<int> idsList);

  Future<List<NoteModel>> getNotes(UserModel user);

  Future<void> deleteAllNotes(UserModel user);
}

class NotesIsarDatasource implements NotesLocalDatasource {
  final Isar isar;

  NotesIsarDatasource(this.isar);

  @override
  Future<void> addNote(UserModel user, NoteModel note) async {
    try {
      await isar.writeTxn(() async {
        note.user.value = user;

        await isar.noteModels.put(note);
        await note.user.save();

        if (!user.notes.any((e) => e.isarId == note.isarId)) {
          user.notes.add(note);
        }
        await user.notes.save();
      });
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllNotes(UserModel user) async {
    try {
      await isar.writeTxn(() async {
        await user.notes.load();
        final ids = user.notes.map((e) => e.isarId).toList();

        await isar.noteModels.deleteAll(ids);

        user.notes.clear();
        await user.notes.save();
      });
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteNote(List<int> idsList) async {
    try {
      if (idsList.isNotEmpty) {
        await isar.writeTxn(() async {
          await isar.noteModels.deleteAll(idsList);
        });
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<NoteModel>> getNotes(UserModel user) async {
    try {
      await user.notes.load();
      return user.notes.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateNote(UserModel user, NoteModel note) async {
    try {
      await isar.writeTxn(() async {
        await isar.noteModels.put(note);

        if (note.user.value?.isarId != user.isarId) {
          note.user.value = user;
          await note.user.save();
        }
      });
    } catch (e) {
      throw CacheException();
    }
  }
}
