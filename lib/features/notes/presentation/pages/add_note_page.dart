import 'package:tasky/core/imports.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key, required this.note});
  final NoteEntity note;

  AddNotePage.empty({super.key})
    : note = NoteEntity(
        id: const Uuid().v4(),
        title: "",
        body: "",
        createdAt: DateTime.now(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotesBloc>(),
      child: AddNoteView(note: note),
    );
  }
}
