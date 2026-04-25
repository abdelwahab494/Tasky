import 'package:tasky/core/imports.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with FormHelperMixin {
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
                            AppAssets.imagesLogo,
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
                                  SvgPicture.asset(AppAssets.imagesWelcomeIcon),
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
                                AppAssets.imagesWelcomeImage,
                                width: AppSizes.w215,
                                height: AppSizes.h204,
                              ),
                              Gap(AppSizes.h28),
                              Form(
                                key: formKey,
                                child: CustomTextField(
                                  title: s.yourName,
                                  controller: firstC,
                                  validationMessage: S
                                      .of(context)
                                      .pleaseEnterYourName,
                                  hintText: s.egAbdelwahabMo,
                                ),
                              ),
                              Gap(AppSizes.h30),
                              BlocListener<UserBloc, UserState>(
                                listener: (context, state) {
                                  if (state is UserSuccess) {
                                    context.showSuccess(state.message);
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (c) => const NavRoot(),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                  if (state is UserError) {
                                    context.showError(state.message);
                                  }
                                },
                                child: ElevatedButton(
                                  onPressed: () => context.read<UserBloc>().add(
                                    LoginRequested(
                                      LoginParams(firstC.text.trim()),
                                    ),
                                  ),
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
