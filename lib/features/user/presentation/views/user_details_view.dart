import 'package:tasky/core/imports.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView>with FormHelperMixin {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      title: s.userName,
                      controller: firstC,
                      validationMessage: s.pleaseEnterYourName,
                      hintText: s.egAbdelwahabMo,
                    ),
                    Gap(AppSizes.h20),
                    CustomTextField(
                      title: s.motivationQuote,
                      controller: secC,
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
        // onPressed: () => controller.changeUserDetailes(context),
        onPressed: (){},
        title: s.saveChanges,
        icon: Icons.check_rounded,
      ),
    );
  }
}
