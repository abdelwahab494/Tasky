import 'package:tasky/core/imports.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameC = TextEditingController();
  final TextEditingController _taskDescC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isHighPriority = false;

  @override
  void dispose() {
    _taskDescC.dispose();
    _taskNameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("New Task")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    title: "Task Name",
                    controller: _taskNameC,
                    validationMessage: "Please Enter The Task Name.",
                    autofocus: true,
                  ),
                  Gap(20),
                  CustomTextField(
                    title: "Task Description",
                    controller: _taskDescC,
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
        bottomNavigationBar: CustomElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            await PrefHelper.addNewTask(
              TaskModel(
                taskName: _taskNameC.text.trim(),
                taskDesc: _taskDescC.text.trim(),
                isHighPriority: isHighPriority,
              ),
            );
            Navigator.of(context).pop(true);
          },
          title: "Add Task",
          icon: Icons.add_rounded,
        ),
      ),
    );
  }
}
