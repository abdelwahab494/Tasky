import 'package:tasky/core/imports.dart';

abstract class NotesLocalDatasource {
  Future<void> addNote(NoteModel note);

  Future<void> updateNote(NoteModel note);

  Future<void> deleteNote(List<int> idsList);

  Future<List<NoteModel>> getNotes();

  Future<void> deleteAllNotes();
}

class NotesIsarDatasource implements NotesLocalDatasource {
  final Isar isar;

  NotesIsarDatasource(this.isar);

  @override
  Future<void> addNote(NoteModel note) async {
    try {
      await isar.writeTxn(() => isar.noteModels.put(note));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllNotes() async {
    try {
      await isar.writeTxn(() => isar.noteModels.clear());
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteNote(List<int> idsList) async {
    try {
      await isar.writeTxn(() => isar.noteModels.deleteAll(idsList));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<NoteModel>> getNotes() {
    try {
      return isar.noteModels.where().findAll();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    try {
      await isar.writeTxn(() => isar.noteModels.put(note));
    } catch (e) {
      throw CacheException();
    }
  }
}
