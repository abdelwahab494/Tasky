import 'package:intl/intl.dart';
import 'package:tasky/core/imports.dart';
import 'dart:ui' as ui;

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key, this.note});
  final NoteModel? note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(false),
              icon: Icon(Icons.check, size: 30),
            ),
          ],
          actionsPadding: EdgeInsets.only(right: 8),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(16, 5, 16, 30),
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
                      Text(
                        formatNoteDate(note?.dateTime),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Gap(5),
                      Directionality(
                        textDirection: isArabic(controller.titleC.text)
                            ? ui.TextDirection.rtl
                            : ui.TextDirection.ltr,
                        child: TextField(
                          controller: controller.titleC,
                          style: Theme.of(context).textTheme.displayMedium!
                              .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                          decoration: const InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff9E9E9E),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  letterSpacing: 0.3,
                                ),
                            decoration: const InputDecoration(
                              hintText: "Note something down ..",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff9E9E9E),
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

  String formatNoteDate(DateTime? dateTime) {
    final date = DateFormat('yyyy-MM-dd').format(dateTime ?? DateTime.now());
    final time = DateFormat('h:mm a').format(dateTime ?? DateTime.now());
    return '$date • $time';
  }

  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }
}
