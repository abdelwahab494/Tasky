import 'package:tasky/core/imports.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> saveData() async {
    await PrefHelper.saveName(_nameC.text.trim());
    await PrefHelper.saveQuote("One task at a time. One step closer.");
  }

  @override
  void dispose() {
    _nameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(40),
              Center(
                child: SizedBox(
                  height: size.height * 0.95,
                  child: Column(
                    children: [
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 16,
                        children: [
                          SvgPicture.asset(
                            "assets/images/logo.svg",
                            height: 42,
                            width: 42,
                          ),
                          Text(
                            "Tasky",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Text(
                                    "Welcome To Tasky",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 24),
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/welcome icon.svg",
                                  ),
                                ],
                              ),
                              Gap(8),
                              Text(
                                "Your productivity journey starts here.",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Gap(24),
                              SvgPicture.asset(
                                "assets/images/welcome image.svg",
                                width: 215,
                                height: 204.39,
                              ),
                              Gap(28),
                              Form(
                                key: _formKey,
                                child: CustomTextField(
                                  title: "Your Name",
                                  controller: _nameC,
                                  validationMessage: "Please Enter Your Name.",
                                  hintText: "e.g. Abdelwahab Mo",
                                ),
                              ),
                              Gap(30),
                              ElevatedButton(
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  saveData();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => RootScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: DarkColors.primary,
                                  foregroundColor: DarkColors.text2,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                ),
                                child: Text(
                                  "Let’s Get Started",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
