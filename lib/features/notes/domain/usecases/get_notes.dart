import 'package:dartz/dartz.dart';
import 'package:tasky/core/imports.dart';

@LazySingleton()
class GetNotesUsecase implements UseCase<List<NoteEntity>, NoParams> {
  final NotesRepo repo;

  GetNotesUsecase(this.repo);

  @override
  Future<Either<Failure, List<NoteEntity>>> call(params) {
    return repo.getNotes();
  }
}
