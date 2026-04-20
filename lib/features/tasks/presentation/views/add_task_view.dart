import 'package:tasky/core/imports.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> with FormHelperMixin {
  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: AppSizes.h20),
              sliver: SliverCustomAppbar(title: s.toDoTasks),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
              sliver: SliverToBoxAdapter(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        title: s.title,
                        controller: firstC,
                        validationMessage: s.pleaseEnterTheTaskName,
                        autofocus: true,
                      ),
                      Gap(AppSizes.h20),
                      CustomTextField(
                        title: s.description,
                        controller: secC,
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
                          Switch(
                            value: isHighPriority,
                            onChanged: (value) {
                              setState(() {
                                isHighPriority = value;
                              });
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
        bottomNavigationBar: BlocListener<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is TasksSuccess) {
              context.showSuccess(state.message);
              Navigator.pop(context, true);
            }
          },
          child: CustomElevatedButton(
            onPressed: () => context.read<TasksBloc>().add(
              TaskAddRequested(
                TaskParams(
                  taskName: firstC.text.trim(),
                  taskDesc: secC.text.trim().isNotEmpty
                      ? secC.text.trim()
                      : null,
                  isHighPriority: isHighPriority,
                  isDone: false,
                ),
              ),
            ),
            title: s.addTask,
            icon: Icons.add_rounded,
          ),
        ),
      ),
    );
  }
}
