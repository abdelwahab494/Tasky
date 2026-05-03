import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class NotesRepoImpl implements NotesRepo {
  final NotesLocalDatasource source;
  final SessionHelper session;

  const NotesRepoImpl(this.source, this.session);

  @override
  Future<Either<Failure, Unit>> addNote(NoteEntity note) async {
    try {
      final model = NoteModel.fromEntity(note);
      final user = await session.getCurrentUser();
      await source.addNote(user, model);
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
      final user = await session.getCurrentUser();
      await source.deleteAllNotes(user);
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
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    try {
      final user = await session.getCurrentUser();
      final notes = await source.getNotes(user);
      return Right(notes.map((note) => note.toEntity()).toList());
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
      final user = await session.getCurrentUser();
      await source.updateNote(user, model);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
