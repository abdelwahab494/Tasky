part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotesRequested extends NotesEvent {}

class AddNoteRequested extends NotesEvent {
  final AddNoteParams params;

  const AddNoteRequested(this.params);

  @override
  List<Object> get props => [params];
}

class UpdateNoteRequested extends NotesEvent {
  final UpdateNoteParams params;

  const UpdateNoteRequested(this.params);

  @override
  List<Object> get props => [params];
}

class DeleteNotesRequested extends NotesEvent {
  final DeleteNotesParams params;

  const DeleteNotesRequested(this.params);

  @override
  List<Object> get props => [params];
}

class DeleteAllNotesRequested extends NotesEvent {}

class SearchNotesRequested extends NotesEvent {
  final String keyword;

  const SearchNotesRequested(this.keyword);
}

class ResetSearchRequested extends NotesEvent {}

class ResetDeletingRequested extends NotesEvent {}

class ToggleDeleteNoteRequested extends NotesEvent {
  final NoteEntity note;

  const ToggleDeleteNoteRequested(this.note);
}
