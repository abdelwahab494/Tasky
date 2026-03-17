import 'package:flutter/cupertino.dart';
import 'package:tasky/core/imports.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

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
              sliver: Consumer<NotesController>(
                builder: (context, controller, child) {
                  if (controller.notesList.isEmpty && !controller.isSearching) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: SizedBox(
                        width: double.infinity,
                        height: AppSizes.h200,
                        child: Center(
                          child: FittedBox(
                            child: SizedBox(
                              width: AppSizes.w160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        AppSizes.w60,
                                        AppSizes.h0,
                                        AppSizes.w60,
                                        AppSizes.h20,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/icons/notes.svg",
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).primaryColor,
                                          BlendMode.srcIn,
                                        ),
                                        width: AppSizes.w250,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      s.noNotesYet,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: AppSizes.sp500,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      s.addyourfirstone,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontSize: AppSizes.sp500),
                                    ),
                                  ),
                                  Gap(AppSizes.h60),
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
                    mainAxisSpacing: AppSizes.h8,
                    crossAxisSpacing: AppSizes.w8,
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
                        title: s.deleteNotes,
                        contentText:
                            s.theselectednoteswillbepermanentlydeleted,
                        action: s.delete,
                      );
                      if (context.mounted && result == true) {
                        context.read<NotesController>().deleteNotes();
                      }
                    },
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r500),
                    ),
                    child: Icon(CupertinoIcons.delete, size: AppSizes.r25),
                  )
                : StreamBuilder<bool>(
                    stream: controller.buttonStream,
                    initialData: true,
                    builder: (context, snapshot) {
                      final bool show = snapshot.data!;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: show ? AppSizes.w170 : AppSizes.w57,
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
                            borderRadius: BorderRadius.circular(AppSizes.r500),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                size: AppSizes.r25,
                              ).animate().scale(end: const Offset(1.1, 1.1)),
                              if (show) Gap(AppSizes.w5),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: show ? AppSizes.w90 : AppSizes.w0,
                                child: FittedBox(
                                  child: Text(
                                    s.addNewNote,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppSizes.sp15,
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
