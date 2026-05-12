import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class DeleteNotesUsecase implements UseCase<Unit, DeleteNotesParams> {
  final NotesRepo repo;

  DeleteNotesUsecase(this.repo);

  @override
  Future<Either<Failure, Unit>> call(params) {
    return repo.deleteNote(params.isarIdsList);
  }
}

class DeleteNotesParams {
  final List<int> isarIdsList;

  const DeleteNotesParams({required this.isarIdsList});
}
