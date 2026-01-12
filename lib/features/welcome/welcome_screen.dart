import 'package:tasky/core/imports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(40),
              Center(
                child: SizedBox(
                  height: size.height * 0.95,
                  child: Column(
                    children: [
                      const Gap(16),
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
                              const Gap(8),
                              Text(
                                "Your productivity journey starts here.",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const Gap(24),
                              SvgPicture.asset(
                                "assets/images/welcome image.svg",
                                width: 215,
                                height: 204.39,
                              ),
                              const Gap(28),
                              Consumer<WelcomeController>(
                                builder:
                                    (
                                      BuildContext context,
                                      WelcomeController controller,
                                      Widget? child,
                                    ) {
                                      return Form(
                                        key: controller.formKey,
                                        child: CustomTextField(
                                          title: "Your Name",
                                          controller: controller.nameC,
                                          validationMessage:
                                              "Please Enter Your Name.",
                                          hintText: "e.g. Abdelwahab Mo",
                                        ),
                                      );
                                    },
                              ),
                              const Gap(30),
                              Consumer<WelcomeController>(
                                builder: (context, controller, child) {
                                  return ElevatedButton(
                                    onPressed: () =>
                                        controller.saveUserName(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: DarkColors.primary,
                                      foregroundColor: DarkColors.text2,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                    ),
                                    child: Text(
                                      "Let's Get Started",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                },
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
