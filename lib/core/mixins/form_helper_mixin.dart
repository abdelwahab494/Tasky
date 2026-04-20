import 'package:tasky/core/imports.dart';

mixin FormHelperMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstC = TextEditingController();
  final TextEditingController secC = TextEditingController();

  @override
  void dispose() {
    firstC.dispose();
    secC.dispose();
    super.dispose();
  }
}
