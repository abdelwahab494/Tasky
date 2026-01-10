import 'package:tasky/core/imports.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider(
        create: (_) => AddTaskController(),
        builder: (context, _) {
          print("Build main");
          final AddTaskController addTaskController = context
              .read<AddTaskController>();
          return Scaffold(
            appBar: AppBar(title: Text("New Task")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: addTaskController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        title: "Title",
                        controller: addTaskController.taskNameC,
                        validationMessage: "Please Enter The Task Name.",
                        autofocus: true,
                      ),
                      Gap(20),
                      CustomTextField(
                        title: "Description",
                        controller: addTaskController.taskDescC,
                        validationMessage: '',
                        maxLines: 5,
                        validate: false,
                      ),
                      Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Selector<AddTaskController, bool>(
                            selector: (BuildContext context, controller) =>
                                controller.isHighPriority,
                            builder:
                                (
                                  BuildContext context,
                                  bool value,
                                  Widget? child,
                                ) {
                                  print("build switch");
                                  return Switch(
                                    value: value,
                                    onChanged: (value) {
                                      addTaskController.isHighPriority = value;
                                    },
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
            bottomNavigationBar: CustomElevatedButton(
              onPressed: () =>
                  context.read<AddTaskController>().addNewTask(context),
              title: "Add Task",
              icon: Icons.add_rounded,
            ),
          );
        },
      ),
    );
  }
}
