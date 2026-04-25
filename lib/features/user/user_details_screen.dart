import 'package:tasky/core/imports.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<UserDetailsController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: AppSizes.h20),
                  sliver: SliverCustomAppbar(title: s.userDetails),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            title: s.userName,
                            controller: controller.usernameC,
                            validationMessage: s.pleaseEnterYourName,
                            hintText: s.egAbdelwahabMo,
                          ),
                          Gap(AppSizes.h20),
                          CustomTextField(
                            title: s.motivationQuote,
                            controller: controller.quoteC,
                            validationMessage: '',
                            maxLines: 5,
                            hintText: s.egOnetaskatatimeOnestepcloser,
                            validate: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: CustomElevatedButton(
              onPressed: () => controller.changeUserDetailes(context),
              title: s.saveChanges,
              icon: Icons.check_rounded,
            ),
          );
        },
      ),
    );
  }
}
