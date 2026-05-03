import 'package:tasky/core/imports.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key, required this.user});
  final UserEntity user;

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView>
    with FormHelperMixin {
  @override
  void initState() {
    super.initState();
    firstC.text = widget.user.name;
    secC.text = widget.user.quote ?? "";
  }

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
      bottomNavigationBar: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            context.showSuccess(state.message);
            Navigator.of(context).pop(true);
          }
          if (state is UserError) {
            context.showError(state.message);
            Navigator.of(context).pop();
          }
        },
        child: CustomElevatedButton(
          onPressed: () {
            if (firstC.text.trim() == widget.user.name &&
                secC.text.trim() == widget.user.quote) {
              Navigator.of(context).pop();
              return;
            }
            context.read<UserBloc>().add(
              SaveUserRequested(
                SaveUserParams(
                  user: widget.user.copyWith(
                    name: firstC.text.trim(),
                    quote: secC.text.trim(),
                  ),
                ),
              ),
            );
          },
          title: s.saveChanges,
          icon: Icons.check_rounded,
        ),
      ),
    );
  }
}
