import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            Consumer<UserDetailsController>(
              builder: (context, controller, child) {
                return SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.image != null) {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Image.file(File(controller.image!)),
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
                                backgroundImage: controller.image == null
                                    ? const AssetImage(AppAssets.imagesProfile)
                                    : FileImage(File(controller.image!)),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -AppSizes.h12,
                            right: -AppSizes.w10,
                            child: Selector<ThemeController, bool>(
                              selector: (context, controller) =>
                                  controller.isDark,
                              builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () =>
                                      controller.selectImageActions(context),
                                  style: IconButton.styleFrom(
                                    backgroundColor: value
                                        ? DarkColors.backGround2
                                        : LightColors.backGround2,
                                    foregroundColor: value
                                        ? DarkColors.text2
                                        : LightColors.text2,
                                    side: value
                                        ? BorderSide.none
                                        : BorderSide(color: LightColors.border),
                                    iconSize: AppSizes.w20,
                                  ),
                                  icon: const Icon(Icons.camera_alt_outlined),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Gap(AppSizes.h16),
                      Selector<ThemeController, bool>(
                        selector: (context, controller) => controller.isDark,
                        builder: (context, value, child) {
                          return Skeletonizer(
                            enabled: controller.isLoading,
                            containersColor: value ? null : LightColors.text4,
                            child: Column(
                              children: [
                                Text(
                                  controller.isLoading
                                      ? "Abdelwahab Mo."
                                      : controller.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: AppSizes.sp20),
                                ),
                                Gap(AppSizes.h4),
                                Text(
                                  controller.isLoading
                                      ? "One task at a time. One step closer."
                                      : controller.quote,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
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
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontSize: AppSizes.sp20),
                      ),
                      Gap(AppSizes.h16),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: context.read<UserDetailsController>(),
                              child: const UserDetailsScreen(),
                            ),
                          ),
                        ),
                        child: ProfileRow(
                          svgPicture: "assets/icons/profile.svg",
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
                        onTap: () =>
                            context.read<HomeController>().logOut(context),
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
        ),
      ),
    );
  }
}
