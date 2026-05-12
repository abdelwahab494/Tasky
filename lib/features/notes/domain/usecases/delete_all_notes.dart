import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class DeleteAllNotesUsecase implements UseCase<Unit, NoParams> {
  final NotesRepo repo;

  DeleteAllNotesUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(params) {
    return repo.deleteAllNotes();
  }
}
