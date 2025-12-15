import 'package:tasky/core/imports.dart';

class Dialogs {
  static Future<bool?> showEditTaskSheet({
    required BuildContext context,
    required TaskModel task,
  }) {
    final TextEditingController taskNameC = TextEditingController(
      text: task.taskName,
    );
    final TextEditingController taskDescC = TextEditingController(
      text: task.taskDesc,
    );
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isHighPriority = task.isHighPriority;

    Future<void> editTask(
      TaskModel task,
      TextEditingController taskNameC,
      TextEditingController taskDescC,
      bool isHighPriority,
    ) async {
      final List<TaskModel> tasksList = await PrefHelper.getTasksList();
      final oldTaskIndex = tasksList.indexWhere(
        (element) =>
            element.taskName == task.taskName &&
            element.taskDesc == task.taskDesc &&
            element.isHighPriority == task.isHighPriority &&
            element.isDone == task.isDone,
      );
      final TaskModel editedTask = TaskModel(
        taskName: taskNameC.text.trim(),
        taskDesc: taskDescC.text.trim(),
        isHighPriority: isHighPriority,
        isDone: task.isDone,
      );
      tasksList[oldTaskIndex] = editedTask;
      await PrefHelper.updateTasksList(tasksList);
    }

    return showModalBottomSheet<bool?>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 5,
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                        ),
                        Gap(16),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      title: "Task Name",
                                      controller: taskNameC,
                                      validationMessage:
                                          "Please Enter The Task Name.",
                                      // autofocus: true,
                                    ),
                                    Gap(20),
                                    CustomTextField(
                                      title: "Task Description",
                                      controller: taskDescC,
                                      validationMessage: '',
                                      maxLines: 5,
                                      validate: false,
                                    ),
                                    Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "High Priority",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        Switch(
                                          value: isHighPriority,
                                          onChanged: (value) {
                                            setState(
                                              () => isHighPriority = value,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return;
                              await editTask(
                                task,
                                taskNameC,
                                taskDescC,
                                isHighPriority,
                              );
                              Navigator.of(context).pop(true);
                            },
                            title: "Edit Task",
                            icon: Icons.mode_edit_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<bool?> showDeletAlertDialog({
    required BuildContext context,
    required String title,
    required String contentText,
    required String action,
  }) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontSize: 24),
          content: Text(contentText),
          contentTextStyle: Theme.of(context).textTheme.titleSmall,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              child: Text(action),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          contentPadding: EdgeInsetsGeometry.fromLTRB(25, 12, 25, 12),
          actionsPadding: EdgeInsetsGeometry.fromLTRB(25, 0, 25, 16),
        );
      },
    );
  }

  static Future<ImageActionsEnum?> showImageSourceDialog({
    required BuildContext context,
  }) async {
    return showDialog<ImageActionsEnum?>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          // title: Text("Choose Image From"),
          // titleTextStyle: Theme.of(
          //   context,
          // ).textTheme.titleMedium!.copyWith(fontSize: 24),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(ImageActionsEnum.camera);
              },
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                spacing: 16,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 18,
                  ),
                  Text(
                    "Open Camera",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(ImageActionsEnum.gallery);
              },
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

              child: Row(
                spacing: 16,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 18,
                  ),
                  Text(
                    "Choose From Gallery",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(ImageActionsEnum.delete);
              },
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                spacing: 16,
                children: [
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                    size: 18,
                  ),
                  Text(
                    "Remove Image",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
