import 'package:tasky/core/imports.dart';

class AddTaskController extends ChangeNotifier {
  final TextEditingController _taskNameC = TextEditingController();
  final TextEditingController _taskDescC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHighPriority = false;

  TextEditingController get taskNameC => _taskNameC;
  TextEditingController get taskDescC => _taskDescC;
  GlobalKey<FormState> get formKey => _formKey;
  bool get isHighPriority => _isHighPriority;

  set isHighPriority(bool value) {
    _isHighPriority = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _taskNameC.dispose();
    _taskDescC.dispose();
    super.dispose();
  }

  Future<void> addNewTask(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final navigator = Navigator.of(context);
    await PrefHelper.addNewTask(
      TaskModel(
        taskName: _taskNameC.text.trim(),
        taskDesc: _taskDescC.text.trim(),
        isHighPriority: _isHighPriority,
      ),
    );
    navigator.pop(true);
  }
}
