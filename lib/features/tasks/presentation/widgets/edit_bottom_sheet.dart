import 'package:tasky/core/imports.dart';

class EditBottomSheet extends StatefulWidget {
  const EditBottomSheet({super.key, required this.task});
  final TaskEntity task;

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet>
    with FormHelperMixin {
  late bool isHighPriority;

  @override
  void initState() {
    super.initState();
    isHighPriority = widget.task.isHighPriority;
    taskNameC.text = widget.task.taskName;
    taskDescC.text = widget.task.taskDesc ?? "";
  }

  @override
  Widget build(BuildContext context) {
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
                    color: Theme.of(context).colorScheme.primaryContainer,
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
                              validationMessage: "Please Enter The Task Name.",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    setState(() => isHighPriority = value);
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
                      final TaskParams editedTask = TaskParams(
                        id: widget.task.id,
                        taskName: taskNameC.text.trim(),
                        taskDesc: taskDescC.text.trim(),
                        isHighPriority: isHighPriority,
                        isDone: widget.task.isDone,
                      );
                      context.read<TasksBloc>().add(
                        TaskUpdateRequested(editedTask),
                      );
                      navigator.pop(true);
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
  }
}
