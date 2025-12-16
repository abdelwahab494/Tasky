import 'package:tasky/core/imports.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _usernameC = TextEditingController();
  final TextEditingController _quoteC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> saveChanges() async {
    await PrefHelper.saveName(_usernameC.text.trim());
    await PrefHelper.saveQuote(
      _quoteC.text.trim().isEmpty || _quoteC.text == ""
          ? "One task at a time. One step closer."
          : _quoteC.text.trim(),
    );
  }

  Future<void> getUserData() async {
    String fetchedUsername = await PrefHelper.getName() ?? "";
    String fetchedQuote = await PrefHelper.getQuote() ?? "";

    setState(() {
      _usernameC.text = fetchedUsername;
      _quoteC.text = fetchedQuote;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameC.dispose();
    _quoteC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("User Details")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        title: "User Name",
                        controller: _usernameC,
                        validationMessage: "Please Enter Your Name.",
                        hintText: "e.g. Abdelwahab Mo.",
                      ),
                      Gap(20),
                      CustomTextField(
                        title: "Motivation Quote",
                        controller: _quoteC,
                        validationMessage: '',
                        maxLines: 5,
                        hintText: "e.g. One task at a time. One step closer.",
                        validate: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            await saveChanges();
            Navigator.of(context).pop(true);
          },
          title: "Save Changes",
          icon: Icons.check_rounded,
        ),
      ),
    );
  }
}
