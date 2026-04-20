import 'package:tasky/core/imports.dart';
import 'dart:ui' as ui;

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key, this.note});
  final NoteEntity? note;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: AppSizes.h70,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(false),
              icon: Icon(Icons.check, size: AppSizes.r30),
            ),
          ],
          actionsPadding: EdgeInsets.only(right: AppSizes.w8),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(
            AppSizes.w16,
            AppSizes.h5,
            AppSizes.w16,
            AppSizes.h30,
          ),
          child: Consumer<NotesController>(
            builder:
                (
                  BuildContext context,
                  NotesController controller,
                  Widget? child,
                ) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (note != null)
                        Text(
                          note!.createdAt.formatDate(
                            formatType: FormatDateEnum.dateTime,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Colors.grey,
                                fontSize: AppSizes.sp12,
                              ),
                        ),
                      Gap(AppSizes.h5),
                      Directionality(
                        textDirection: isArabic(controller.titleC.text)
                            ? ui.TextDirection.rtl
                            : ui.TextDirection.ltr,
                        child: TextField(
                          controller: controller.titleC,
                          style: Theme.of(context).textTheme.displayMedium!
                              .copyWith(
                                fontSize: AppSizes.sp20,
                                fontWeight: FontWeight.bold,
                              ),
                          decoration: InputDecoration(
                            hintText: s.title,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.sp20,
                              color: const Color(0xff9E9E9E),
                            ),
                            filled: false,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Directionality(
                          textDirection: isArabic(controller.titleC.text)
                              ? ui.TextDirection.rtl
                              : ui.TextDirection.ltr,
                          child: TextField(
                            controller: controller.bodyC,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 1,
                            maxLines: null,
                            autofocus: true,
                            style: Theme.of(context).textTheme.displayMedium!
                                .copyWith(
                                  fontSize: AppSizes.sp16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  letterSpacing: 0.3,
                                ),
                            decoration: InputDecoration(
                              hintText: s.notesomethingdown,
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: AppSizes.sp16,
                                color: const Color(0xff9E9E9E),
                              ),
                              filled: false,
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }

  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }
}
