import 'package:tasky/core/imports.dart';

class Dialogs {
  static Future<void> showEditTaskSheet({
    required BuildContext context,
    required TaskEntity task,
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
      TaskEntity task,
      TextEditingController taskNameC,
      TextEditingController taskDescC,
      bool isHighPriority,
    ) async {
      final TaskParams editedTask = TaskParams(
        id: task.id,
        taskName: taskNameC.text.trim(),
        taskDesc: taskDescC.text.trim(),
        isHighPriority: isHighPriority,
        isDone: task.isDone,
      );
      context.read<TasksBloc>().add(TaskUpdateRequested(editedTask));
    }

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSizes.r20),
                        topRight: Radius.circular(AppSizes.r20),
                      ),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: AppSizes.w1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: AppSizes.w60,
                          height: AppSizes.h5,
                          margin: EdgeInsets.symmetric(
                            horizontal: AppSizes.w16,
                            vertical: AppSizes.h8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.r1000),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                        ),
                        Gap(AppSizes.h16),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.w16,
                              vertical: AppSizes.h8,
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
                                    Gap(AppSizes.h20),
                                    CustomTextField(
                                      title: "Task Description",
                                      controller: taskDescC,
                                      validationMessage: '',
                                      maxLines: 5,
                                      validate: false,
                                    ),
                                    Gap(AppSizes.h20),
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
                              final navigator = Navigator.of(context);
                              await editTask(
                                task,
                                taskNameC,
                                taskDescC,
                                isHighPriority,
                              );
                              navigator.pop();
                              taskNameC.dispose();
                              taskDescC.dispose();
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
          ).textTheme.titleMedium!.copyWith(fontSize: AppSizes.sp24),
          content: Text(contentText),
          contentTextStyle: Theme.of(context).textTheme.titleSmall,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.sp16,
                ),
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.sp16,
                ),
              ),
              child: Text(action),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          contentPadding: EdgeInsetsGeometry.fromLTRB(
            AppSizes.w25,
            AppSizes.h12,
            AppSizes.w25,
            AppSizes.h12,
          ),
          actionsPadding: EdgeInsetsGeometry.fromLTRB(
            AppSizes.w25,
            AppSizes.h0,
            AppSizes.w25,
            AppSizes.h16,
          ),
        );
      },
    );
  }

  static Future<ImageActionsEnum?> showImageSourceDialog({
    required BuildContext context,
    required UserDetailsController controller,
  }) async {
    return showDialog<ImageActionsEnum?>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(ImageActionsEnum.camera);
              },
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w16,
                vertical: AppSizes.h16,
              ),
              child: Row(
                spacing: AppSizes.w16,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).primaryColor,
                    size: AppSizes.r22,
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
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w16,
                vertical: AppSizes.h16,
              ),
              child: Row(
                spacing: AppSizes.w16,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    color: Theme.of(context).primaryColor,
                    size: AppSizes.r22,
                  ),
                  Text(
                    "Choose From Gallery",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            if (controller.image != null)
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(ImageActionsEnum.delete);
                },
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h16,
                ),
                child: Row(
                  spacing: AppSizes.w16,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.error,
                      size: AppSizes.r22,
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

  static void showDeletingMessage({
    required BuildContext context,
    required HomeController controller,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            "Task Deleted Successfully.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(
            horizontal: AppSizes.w16,
            vertical: AppSizes.h8,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          elevation: 0,
          action: SnackBarAction(
            label: "Undo",
            onPressed: () async {
              await PrefHelper.updateTasksList(
                controller.tasksListBeforeDeleting,
              );
              controller.loadData();
            },
            textColor: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
      );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h8,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
        elevation: 0,
      ),
    );
  }
}
