import 'package:tasky/core/imports.dart';

class WelcomeController extends ChangeNotifier {
  final TextEditingController _nameC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController get nameC => _nameC;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void dispose() {
    _nameC.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    await PrefHelper.saveName(_nameC.text.trim());
    await PrefHelper.saveQuote("One task at a time. One step closer.");
  }

  Future<void> saveUserName(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final navigator = Navigator.of(context);
    await saveData();
    navigator.pushReplacement(MaterialPageRoute(builder: (c) => const NavRoot()));
  }
}
