import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

class UpdateNoteUsecase implements UseCase<Unit, UpdateNoteParams> {
  final NotesRepo repo;

  const UpdateNoteUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(UpdateNoteParams params) {
    final NoteEntity entity = NoteEntity(
      isarId: params.isarId,
      id: params.id,
      title: params.title,
      body: params.body,
      createdAt: DateTime.now(),
    );
    return repo.updateNote(entity);
  }
}

class UpdateNoteParams {
  final int isarId;
  final String id;
  final String title;
  final String body;

  const UpdateNoteParams({
    required this.isarId,
    required this.id,
    required this.title,
    required this.body,
  });
}
