import 'package:tasky/core/imports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(AppSizes.h40),
              Center(
                child: SizedBox(
                  height: size.height * 0.95,
                  child: Column(
                    children: [
                      Gap(AppSizes.h16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: AppSizes.w16,
                        children: [
                          SvgPicture.asset(
                            "assets/images/logo.svg",
                            height: AppSizes.h42,
                            width: AppSizes.w42,
                          ),
                          Text(
                            s.tasky,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.w16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: AppSizes.w10,
                                children: [
                                  Text(
                                    s.welcomeToTasky,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: AppSizes.sp24),
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/welcome icon.svg",
                                  ),
                                ],
                              ),
                              Gap(AppSizes.h8),
                              Text(
                                s.yourProductivityJourneyStartsHere,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: AppSizes.sp16),
                                textAlign: TextAlign.center,
                              ),
                              Gap(AppSizes.h24),
                              SvgPicture.asset(
                                "assets/images/welcome image.svg",
                                width: AppSizes.w215,
                                height: AppSizes.h204,
                              ),
                              Gap(AppSizes.h28),
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
                                          title: s.yourName,
                                          controller: controller.nameC,
                                          validationMessage: S
                                              .of(context)
                                              .pleaseEnterYourName,
                                          hintText: s.egAbdelwahabMo,
                                        ),
                                      );
                                    },
                              ),
                              Gap(AppSizes.h30),
                              Consumer<WelcomeController>(
                                builder: (context, controller, child) {
                                  return ElevatedButton(
                                    onPressed: () =>
                                        controller.saveUserName(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: DarkColors.primary,
                                      foregroundColor: DarkColors.text2,
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppSizes.h10,
                                        horizontal: AppSizes.w10,
                                      ),
                                    ),
                                    child: Text(
                                      s.letsGetStarted,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppSizes.sp18,
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
