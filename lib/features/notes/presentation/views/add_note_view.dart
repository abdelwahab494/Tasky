import 'package:tasky/core/imports.dart';
import 'dart:ui' as ui;

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key, required this.note});
  final NoteEntity note;

  AddNoteView.empty({super.key})
    : note = NoteEntity(
        id: const Uuid().v4(),
        title: "",
        body: "",
        createdAt: DateTime.now(),
      );

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> with FormHelperMixin {
  @override
  void initState() {
    super.initState();
    firstC.text = widget.note.title.trim();
    secC.text = widget.note.body.trim();
  }

  void _saveNote() {
    if (!hasChanged ||
        (firstC.text.trim().isEmpty && secC.text.trim().isEmpty)) {
      Navigator.of(context).pop();
      return;
    }

    if (widget.note.isarId == null) {
      context.read<NotesBloc>().add(
        AddNoteRequested(
          AddNoteParams(title: firstC.text.trim(), body: secC.text.trim()),
        ),
      );
    } else {
      context.read<NotesBloc>().add(
        UpdateNoteRequested(
          UpdateNoteParams(
            isarId: widget.note.isarId!,
            id: widget.note.id,
            title: firstC.text.trim(),
            body: secC.text.trim(),
          ),
        ),
      );
    }
  }

  bool get hasChanged =>
      firstC.text.trim() != widget.note.title ||
      secC.text.trim() != widget.note.body;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          _saveNote();
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: AppSizes.h70,
            actions: [
              BlocListener<NotesBloc, NotesState>(
                listenWhen: (prev, curr) =>
                    curr is NotesError || curr is NotesSuccess,
                listener: (context, state) {
                  if (state is NotesSuccess) {
                    context.showSuccess(state.message);
                    Navigator.of(context).pop(true);
                  }
                  if (state is NotesError) {
                    context.showError(state.message);
                    Navigator.of(context).pop();
                  }
                },
                child: IconButton(
                  onPressed: () {
                    _saveNote();
                  },
                  icon: Icon(Icons.check, size: AppSizes.r30),
                ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.createdAt.formatDate(
                    formatType: FormatDateEnum.dateTime,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                    fontSize: AppSizes.sp12,
                  ),
                ),
                Gap(AppSizes.h5),
                Directionality(
                  textDirection: isArabic(firstC.text)
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  child: TextField(
                    controller: firstC,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                    textDirection: isArabic(secC.text)
                        ? ui.TextDirection.rtl
                        : ui.TextDirection.ltr,
                    child: TextField(
                      controller: secC,
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
            ),
          ),
        ),
      ),
    );
  }

  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }
}
