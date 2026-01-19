import 'package:flutter/cupertino.dart';
import 'package:tasky/core/imports.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppbar(),
            SliverPadding(
              padding: const EdgeInsetsGeometry.all(8),
              sliver: Consumer<NotesController>(
                builder: (context, controller, child) {
                  if (controller.notesList.isEmpty && !controller.isSearching) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: FittedBox(
                            child: SizedBox(
                              width: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        60,
                                        0,
                                        60,
                                        20,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/notes.svg",
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).primaryColor,
                                          BlendMode.srcIn,
                                        ),
                                        width: 250,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "No Notes Yet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: 500,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Add your first one",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontSize: 500),
                                    ),
                                  ),
                                  const Gap(60),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childCount: controller.notesList.length,
                    itemBuilder: (context, index) {
                      final NoteModel note = controller.notesList[index];
                      return GestureDetector(
                        onTap: () => controller.isDeleting
                            ? controller.startDeleting(note)
                            : controller.navigatorfunction(
                                context: context,
                                note: note,
                              ),
                        onLongPress: () => controller.startDeleting(note),
                        child: NoteCard(note: note, controller: controller)
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
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Consumer<HomeController>(
          builder: (context, controller, child) {
            return context.watch<NotesController>().isDeleting
                ? FloatingActionButton(
                    onPressed: () async {
                      final bool? result = await Dialogs.showDeletAlertDialog(
                        context: context,
                        title: "Delete Notes",
                        contentText:
                            "The selected notes will be permanently deleted.",
                        action: "Delete",
                      );
                      if (context.mounted && result == true) {
                        context.read<NotesController>().deleteNotes();
                      }
                    },
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),
                    ),
                    child: const Icon(CupertinoIcons.delete, size: 25),
                  )
                : StreamBuilder<bool>(
                    stream: controller.buttonStream,
                    initialData: true,
                    builder: (context, snapshot) {
                      final bool show = snapshot.data!;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: show ? 170 : 57,
                        decoration: BoxDecoration(
                          shape: show ? BoxShape.rectangle : BoxShape.circle,
                        ),
                        child: FloatingActionButton(
                          onPressed: () => context
                              .read<NotesController>()
                              .navigatorfunction(context: context),
                          backgroundColor: DarkColors.primary,
                          foregroundColor: DarkColors.text2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.add_rounded,
                                size: 25,
                              ).animate().scale(end: const Offset(1.1, 1.1)),
                              if (show) const Gap(5),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: show ? 90 : 0,
                                child: FittedBox(
                                  child: Text(
                                    "Add New Note",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
