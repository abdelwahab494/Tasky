import 'package:tasky/core/imports.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotesBloc>()..add(LoadNotesRequested()),
      child: const NotesView(),
    );
  }
}
