part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<NoteEntity> mainNotesList;
  final List<NoteEntity> notesList;
  final List<NoteEntity> deletingList;
  bool get isDeleting => deletingList.isNotEmpty;
  final bool isSearching;

  const NotesLoaded({
    this.mainNotesList = const [],
    this.notesList = const [],
    this.deletingList = const [],
    this.isSearching = false,
  });

  @override
  List<Object> get props => [
    mainNotesList,
    notesList,
    deletingList,
    isDeleting,
    isSearching,
  ];

  NotesLoaded copyWith({
    List<NoteEntity>? mainNotesList,
    List<NoteEntity>? notesList,
    List<NoteEntity>? deletingList,
    bool? isSearching,
  }) {
    return NotesLoaded(
      mainNotesList: mainNotesList ?? this.mainNotesList,
      notesList: notesList ?? this.notesList,
      deletingList: deletingList ?? this.deletingList,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

final class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object> get props => [message];
}

final class NotesSuccess extends NotesState {
  final String message;

  const NotesSuccess(this.message);

  @override
  List<Object> get props => [message];
}
