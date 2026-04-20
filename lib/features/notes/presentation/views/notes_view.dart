import 'package:flutter/cupertino.dart';
import 'package:tasky/core/imports.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppbar(),
            SliverPadding(
              padding: EdgeInsetsGeometry.all(AppSizes.w8),
              sliver: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  if (state is NotesLoaded) {
                    if (state.notesList.isEmpty) {
                      return EmptyView(
                        svgPath: AppAssets.iconsNotes,
                        title: s.noNotesYet,
                        subTitle: s.addyourfirstone,
                      );
                    }
                    return SliverMasonryGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSizes.h8,
                      crossAxisSpacing: AppSizes.w8,
                      childCount: state.notesList.length,
                      itemBuilder: (context, index) {
                        final NoteEntity note = state.notesList[index];
                        return GestureDetector(
                          onTap: () => state.isDeleting
                              ? context.read<NotesBloc>().add(
                                  ToggleDeleteNoteRequested(note),
                                )
                              : Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => AddNoteScreen(note: note),
                                  ),
                                ),
                          onLongPress: () => context.read<NotesBloc>().add(
                            ToggleDeleteNoteRequested(note),
                          ),
                          child: NoteCard(note: note, state: state)
                              .animate()
                              .fadeIn(
                                duration: Duration(
                                  milliseconds: 100 + index * 50,
                                ),
                              )
                              .scale(
                                duration: Duration(
                                  milliseconds: 100 + index * 50,
                                ),
                                begin: const Offset(0.8, 0.8),
                              ),
                        );
                      },
                    );
                  }
                  return const SliverToBoxAdapter();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoaded) {
              if (state.isDeleting) {
                return FloatingActionButton(
                  onPressed: () async {
                    final bool? result = await Dialogs.showDeletAlertDialog(
                      context: context,
                      title: s.deleteNotes,
                      contentText: s.theselectednoteswillbepermanentlydeleted,
                      action: s.delete,
                    );
                    if (context.mounted && result == true) {
                      context.read<NotesBloc>().add(
                        DeleteNotesRequested(
                          DeleteNotesParams(
                            isarIdsList: state.deletingList
                                .map((note) => note.isarId!)
                                .toList(),
                          ),
                        ),
                      );
                    }
                  },
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r500),
                  ),
                  child: Icon(CupertinoIcons.delete, size: AppSizes.r25),
                );
              }
              return FloatingButton(title: s.addNewNote, onPressed: () {});
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
