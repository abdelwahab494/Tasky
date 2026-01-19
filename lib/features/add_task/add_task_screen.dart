import 'package:tasky/core/imports.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider(
        create: (_) => HomeController(),
        builder: (context, _) {
          final HomeController addTaskController = context
              .read<HomeController>();
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                  sliver: SliverCustomAppbar(title: "To Do Tasks"),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
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
                          const Gap(20),
                          CustomTextField(
                            title: "Description",
                            controller: addTaskController.taskDescC,
                            validationMessage: '',
                            maxLines: 5,
                            validate: false,
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "High Priority",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Selector<HomeController, bool>(
                                selector: (BuildContext context, controller) =>
                                    controller.isHighPriority,
                                builder:
                                    (
                                      BuildContext context,
                                      bool value,
                                      Widget? child,
                                    ) {
                                      return Switch(
                                        value: value,
                                        onChanged: (value) {
                                          addTaskController.isHighPriority =
                                              value;
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
              ],
            ),
            bottomNavigationBar: CustomElevatedButton(
              onPressed: () =>
                  context.read<HomeController>().addNewTask(context),
              title: "Add Task",
              icon: Icons.add_rounded,
            ),
          );
        },
      ),
    );
  }
}
