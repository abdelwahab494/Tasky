import 'package:tasky/core/imports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.w16,
          AppSizes.h20,
          AppSizes.w16,
          AppSizes.h0,
        ),
        child: CustomScrollView(
          slivers: [
            SliverCustomAppbar(title: s.profile),
            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserSuccess) {
                  context.showSuccess(state.message);
                  if (state.message.toLowerCase().contains("out")) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  }
                }
                if (state is UserError) {
                  context.showError(state.message);
                }
              },
              builder: (context, state) {
                if (state is UserLoaded) {
                  return SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (state.currentUser.image != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Image.file(
                                            File(state.currentUser.image!),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: AvatarGlow(
                                    glowRadiusFactor: 0.2,
                                    glowColor: Theme.of(context).primaryColor,
                                    startDelay: const Duration(seconds: 1),
                                    child: CircleAvatar(
                                      radius: AppSizes.r50,
                                      backgroundImage:
                                          state.currentUser.image == null
                                          ? const AssetImage(
                                              AppAssets.imagesProfile,
                                            )
                                          : FileImage(
                                              File(state.currentUser.image!),
                                            ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -AppSizes.h12,
                                  right: -AppSizes.w10,
                                  child: IconButton(
                                    onPressed: () => context
                                        .read<UserDetailsController>()
                                        .selectImageActions(context),
                                    style: IconButton.styleFrom(
                                      backgroundColor: state.currentUser.isDark
                                          ? DarkColors.backGround2
                                          : LightColors.backGround2,
                                      foregroundColor: state.currentUser.isDark
                                          ? DarkColors.text2
                                          : LightColors.text2,
                                      side: state.currentUser.isDark
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: LightColors.border,
                                            ),
                                      iconSize: AppSizes.w20,
                                    ),
                                    icon: const Icon(Icons.camera_alt_outlined),
                                  ),
                                ),
                              ],
                            ),
                            Gap(AppSizes.h16),
                            Column(
                              children: [
                                Text(
                                  state.currentUser.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: AppSizes.sp20),
                                ),
                                Gap(AppSizes.h4),
                                Text(
                                  state.currentUser.quote ??
                                      s.onetaskatatimeOnestepcloser,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ).animate().fadeIn(),
                          ],
                        ),
                      ),
                      SliverGap(AppSizes.h30),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Consumer<ThemeController>(
                          builder: (context, controller, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  s.profileInfo,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: AppSizes.sp20),
                                ),
                                Gap(AppSizes.h16),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const UserDetailsScreen(),
                                    ),
                                  ),
                                  child: ProfileRow(
                                    svgPicture: AppAssets.iconsProfile,
                                    title: s.userDetails,
                                    trailing: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: controller.isDark
                                          ? DarkColors.text2
                                          : LightColors.text2,
                                    ),
                                  ),
                                ),
                                Gap(AppSizes.h10),
                                const Divider(),
                                ProfileRow(
                                  svgPicture: AppAssets.iconsDarkmode,
                                  title: s.darkMode,
                                  trailing: Switch(
                                    value: controller.isDark,
                                    onChanged: (value) async {
                                      await controller.toggleTheme();
                                    },
                                  ),
                                ),
                                const Divider(),
                                Gap(AppSizes.h10),
                                GestureDetector(
                                  onTap: () => context.read<UserBloc>().add(
                                    LogoutRequested(),
                                  ),
                                  child: ProfileRow(
                                    svgPicture: AppAssets.iconsLogout,
                                    title: s.logOut,
                                    trailing: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: controller.isDark
                                          ? DarkColors.text2
                                          : LightColors.text2,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SliverToBoxAdapter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
