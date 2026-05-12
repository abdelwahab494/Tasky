import 'dart:async';
import 'package:tasky/core/imports.dart';

part 'notes_event.dart';
part 'notes_state.dart';

@Injectable()
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUsecase getNotesUsecase;
  final AddNoteUsecase addNoteUsecase;
  final DeleteAllTasksUsecase deleteAllTasksUsecase;
  final DeleteNotesUsecase deleteNotesUsecase;
  final UpdateNoteUsecase updateNoteUsecase;

  NotesBloc({
    required this.getNotesUsecase,
    required this.addNoteUsecase,
    required this.deleteAllTasksUsecase,
    required this.deleteNotesUsecase,
    required this.updateNoteUsecase,
  }) : super(NotesInitial()) {
    on<LoadNotesRequested>(_onLoadNotesRequested);
    on<AddNoteRequested>(_onAddNoteRequested);
    on<DeleteAllNotesRequested>(_onNotesAllDeleted);
    on<DeleteNotesRequested>(_onDeleteNotesRequested);
    on<UpdateNoteRequested>(_onUpdateNoteRequested);
    on<SearchNotesRequested>(_onSearchNotesRequested);
    on<ResetSearchRequested>(_onResetSearchRequested);
    on<ResetDeletingRequested>(_onResetDeletingRequested);
    on<ToggleDeleteNoteRequested>(_onToggleDeleteNoteRequested);
  }

  Future<void> _reload(Emitter<NotesState> emit) async {
    final result = await getNotesUsecase(NoParams());

    result.fold(
      (failure) => emit(const NotesError("Failed To Load Notes!")),
      (notesList) => emit(
        NotesLoaded(
          mainNotesList: List<NoteEntity>.from(notesList),
          notesList: List<NoteEntity>.from(notesList),
        ),
      ),
    );
  }

  Future<void> _onLoadNotesRequested(
    LoadNotesRequested event,
    Emitter<NotesState> emit,
  ) async {
    await _reload(emit);
  }

  Future<void> _onAddNoteRequested(
    AddNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    final result = await addNoteUsecase(event.params);

    if (result.isLeft()) {
      emit(const NotesError("Failed To Add Note!"));
    }

    result.fold(
      (failure) => emit(const NotesError("Failed To Add Note!")),
      (_) => emit(const NotesSuccess("Note Added Successfully")),
    );

    await _reload(emit);
  }

  Future<void> _onNotesAllDeleted(
    DeleteAllNotesRequested event,
    Emitter<NotesState> emit,
  ) async {
    final result = await deleteAllTasksUsecase(NoParams());

    result.fold(
      (failure) => emit(const NotesError("Failed To Delete All Notes!")),
      (_) => emit(const NotesSuccess("All Notes Deleted Successfully")),
    );

    await _reload(emit);
  }

  Future<void> _onDeleteNotesRequested(
    DeleteNotesRequested event,
    Emitter<NotesState> emit,
  ) async {
    final result = await deleteNotesUsecase(event.params);

    result.fold(
      (failure) => emit(const NotesError("Failed To Delete Notes!")),
      (_) => emit(const NotesSuccess("Notes Deleted Successfully")),
    );

    await _reload(emit);
  }

  Future<void> _onUpdateNoteRequested(
    UpdateNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    final result = await updateNoteUsecase(event.params);

    if (result.isLeft()) {
      emit(const NotesError("Failed To Update Notes!"));
    }

    result.fold(
      (failure) => emit(const NotesError("Failed To Update Notes!")),
      (_) => emit(const NotesSuccess("Notes Updated Successfully")),
    );

    await _reload(emit);
  }

  void _onSearchNotesRequested(
    SearchNotesRequested event,
    Emitter<NotesState> emit,
  ) {
    if (state is NotesLoaded) {
      final curr = state as NotesLoaded;
      final filtered = curr.mainNotesList.where((note) {
        final input = event.keyword.toLowerCase();
        return note.title.toLowerCase().contains(input) ||
            note.body.toLowerCase().contains(input);
      }).toList();

      emit(curr.copyWith(notesList: filtered, isSearching: true));
    }
  }

  void _onResetSearchRequested(
    ResetSearchRequested event,
    Emitter<NotesState> emit,
  ) {
    if (state is NotesLoaded) {
      final curr = state as NotesLoaded;
      emit(curr.copyWith(notesList: curr.mainNotesList, isSearching: false));
    }
  }

  void _onToggleDeleteNoteRequested(
    ToggleDeleteNoteRequested event,
    Emitter<NotesState> emit,
  ) {
    if (state is NotesLoaded) {
      final curr = state as NotesLoaded;
      final list = List<NoteEntity>.from(curr.deletingList);

      if (list.contains(event.note)) {
        list.remove(event.note);
      } else {
        list.add(event.note);
      }

      emit(curr.copyWith(deletingList: list));
    }
  }

  void _onResetDeletingRequested(
    ResetDeletingRequested event,
    Emitter<NotesState> emit,
  ) {
    if (state is NotesLoaded) {
      final curr = state as NotesLoaded;

      emit(curr.copyWith(deletingList: []));
    }
  }
}
