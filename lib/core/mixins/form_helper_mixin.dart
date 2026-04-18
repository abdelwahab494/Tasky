import 'package:tasky/core/imports.dart';

mixin FormHelperMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController taskNameC = TextEditingController();
  final TextEditingController taskDescC = TextEditingController();

  @override
  void dispose() {
    taskNameC.dispose();
    taskDescC.dispose();
    super.dispose();
  }
}
