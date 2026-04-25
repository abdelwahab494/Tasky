import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

abstract class NotesRepo {
  Future<Either<Failure, Unit>> addNote(NoteEntity note);

  Future<Either<Failure, Unit>> updateNote(NoteEntity note);

  Future<Either<Failure, Unit>> deleteNote(List<int> idsList);

  Future<Either<Failure, Unit>> deleteAllNotes();

  Future<Either<Failure, List<NoteEntity>>> getNotes();
}
