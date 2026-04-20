import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class NotesRepoImpl implements NotesRepo {
  final NotesLocalDatasource source;

  const NotesRepoImpl(this.source);

  @override
  Future<Either<Failure, Unit>> addNote(NoteEntity note) async {
    try {
      final model = NoteModel.fromEntity(note);
      await source.addNote(model);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAllNotes() async {
    try {
      await source.deleteAllNotes();
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(List<int> idsList) async {
    try {
      await source.deleteNote(idsList);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> loadNotes() async {
    try {
      final List<NoteModel> notesModelList = await source.getNotes();
      final List<NoteEntity> notesList = notesModelList
          .map((note) => note.toEntity())
          .toList();
      return Right(notesList);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(NoteEntity note) async {
    try {
      final model = NoteModel.fromEntity(note);
      await source.updateNote(model);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
