import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class AddNoteUsecase implements UseCase<Unit, AddNoteParams> {
  final NotesRepo repo;

  const AddNoteUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(AddNoteParams params) {
    final NoteEntity entity = NoteEntity(
      id: const Uuid().v4(),
      title: params.title,
      body: params.body,
      createdAt: DateTime.now(),
    );
    return repo.addNote(entity);
  }
}

class AddNoteParams {
  final String title;
  final String body;

  AddNoteParams({required this.title, required this.body});
}
