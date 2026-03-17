import 'package:tasky/core/imports.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
            final S s = S.of(context);
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
                SliverPadding(
                  padding: EdgeInsets.only(top: AppSizes.h20),
                  sliver:  SliverCustomAppbar(title: s.toDoTasks),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: addTaskController.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            title: s.title,
                            controller: addTaskController.taskNameC,
                            validationMessage: s.pleaseEnterTheTaskName,
                            autofocus: true,
                          ),
                          Gap(AppSizes.h20),
                          CustomTextField(
                            title: s.description,
                            controller: addTaskController.taskDescC,
                            validationMessage: '',
                            maxLines: 5,
                            validate: false,
                          ),
                          Gap(AppSizes.h20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                s.highPriority,
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
              title: s.addTask,
              icon: Icons.add_rounded,
            ),
          );
        },
      ),
    );
  }
}
