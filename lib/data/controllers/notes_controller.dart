import 'package:tasky/core/imports.dart';

class NotesController extends ChangeNotifier {
  final List<NoteModel> _notes = [
    NoteModel(
      title: "Hello",
      body:
          "Welcome to our tasky app, we provide an appliction that serve all your tasks optimization.",
      dateTime: DateTime.now(),
    ),
  ];

  List<NoteModel> get notes => _notes;
}
