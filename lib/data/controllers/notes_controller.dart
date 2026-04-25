// import 'package:tasky/core/imports.dart';

// class NotesController extends ChangeNotifier {
//   List<NoteModel> _mainNotesList = [];
//   List<NoteModel> _notesList = [];
//   final List<NoteModel> _deletingList = [];
//   bool _isLoading = false;
//   final TextEditingController _searchC = TextEditingController();
//   final TextEditingController _titleC = TextEditingController();
//   final TextEditingController _bodyC = TextEditingController();
//   NoteModel? _editingNote;
//   bool _isDeleting = false;

//   List<NoteModel> get mainnotesList => _mainNotesList;
//   List<NoteModel> get notesList => _notesList;
//   List<NoteModel> get deletingList => _deletingList;
//   bool get isLoading => _isLoading;
//   bool get isSearching => _searchC.text != "" && _searchC.text.isNotEmpty;
//   TextEditingController get searchC => _searchC;
//   TextEditingController get titleC => _titleC;
//   TextEditingController get bodyC => _bodyC;
//   bool get isDeleting => _isDeleting;

//   NotesController() {
//     init();
//   }

//   void init() {
//     getNotes();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _searchC.dispose();
//     _bodyC.dispose();
//     _titleC.dispose();
//   }

//   Future<void> getNotes() async {
//     _isLoading = true;
//     notifyListeners();
//     final List<NoteModel> fetchedNotesList =
//         []; // await PrefHelper.getNotesList();
//     _mainNotesList = fetchedNotesList;
//     _notesList = fetchedNotesList;
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> saveNote() async {
//     if (_bodyC.text.trim().isEmpty && _titleC.text.trim().isEmpty) {
//       clearControllers();
//       return;
//     }

//     if (_editingNote != null) {
//       final int index = _mainNotesList.indexOf(_editingNote!);
//       if (index != -1) {
//         _mainNotesList.removeAt(index);
//       }
//     }
//     // _mainNotesList.insert(
//     //   0,
//     //   NoteModel(
//     //     title: _titleC.text.trim(),
//     //     body: _bodyC.text.trim(),
//     //     dateTime: DateTime.now(),
//     //   ),
//     // );

//     _notesList = List.from(_mainNotesList);
//     _editingNote = null;
//     clearControllers();

//     notifyListeners();
//     await PrefHelper.updateNotesList(_mainNotesList);
//   }

//   void searchFunction(String keyWord) {
//     _notesList = _mainNotesList.where((note) {
//       final title = note.title.toString().toLowerCase();
//       final body = note.body.toString().toLowerCase();
//       final input = keyWord.toLowerCase();

//       // return title.startsWith(inputw);
//       return title.contains(input) || body.contains(input);
//     }).toList();
//     notifyListeners();
//   }

//   void reset() {
//     _notesList = List.from(_mainNotesList);
//     _searchC.clear();
//     notifyListeners();
//   }

//   Future<void> navigatorfunction({
//     required BuildContext context,
//     NoteModel? note,
//   }) async {
//     _editingNote = note;

//     if (note != null) {
//       controllersSetter(note);
//     } else {
//       clearControllers();
//     }

//     // await Navigator.of(
//     //   context,
//     // ).push(MaterialPageRoute(builder: (_) => AddNoteScreen(note: note)));

//     if (context.mounted) {
//       saveNote();
//     }
//   }

//   void controllersSetter(NoteModel note) {
//     _titleC.text = note.title;
//     _bodyC.text = note.body;
//   }

//   void clearControllers() {
//     _titleC.clear();
//     _bodyC.clear();
//   }

//   void startDeleting(NoteModel note) {
//     if (_deletingList.contains(note)) {
//       _deletingList.removeWhere((e) => e == note);
//       if (_deletingList.isEmpty) {
//         _isDeleting = false;
//       }
//     } else {
//       _isDeleting = true;
//       _deletingList.add(note);
//     }
//     notifyListeners();
//   }

//   Future<void> deleteNotes() async {
//     for (NoteModel note in _deletingList) {
//       _mainNotesList.removeWhere((e) => e == note);
//     }
//     _notesList = List.from(_mainNotesList);
//     _isDeleting = false;
//     _deletingList.clear();
//     notifyListeners();
//     await PrefHelper.updateNotesList(_mainNotesList);
//   }

//   void resetNotesDeleting() {
//     _isDeleting = false;
//     _deletingList.clear();
//     notifyListeners();
//   }
// }
