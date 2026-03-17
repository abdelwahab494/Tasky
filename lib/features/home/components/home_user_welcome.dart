import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class HomeUserWelcome extends StatelessWidget {
  const HomeUserWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Consumer<UserDetailsController>(
      builder:
          (
            BuildContext context,
            UserDetailsController controller,
            Widget? child,
          ) {
            return Skeletonizer(
              enabled: controller.isLoading,
              child: Row(
                spacing: AppSizes.w11,
                children: [
                  Gap(AppSizes.w1),
                  AvatarGlow(
                    glowRadiusFactor: 0.2,
                    glowColor: Theme.of(context).primaryColor,
                    startDelay: const Duration(seconds: 1),
                    child: CircleAvatar(
                      radius: AppSizes.r23,
                      backgroundImage: controller.image == null
                          ? const AssetImage("assets/images/profile.png")
                          : FileImage(File(controller.image!)),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.isLoading
                              ? s.hello
                              : "${s.hello} ${controller.name}",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(letterSpacing: 0.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          controller.isLoading
                              ? s.onetaskatatimeOnestepcloser
                              : controller.quote,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(letterSpacing: 0.25),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Consumer<ThemeController>(
                    builder: (context, controller, child) {
                      return IconButton.filled(
                        onPressed: () async {
                          await controller.toggleTheme();
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: controller.isDark
                              ? DarkColors.backGround2
                              : LightColors.backGround2,
                          foregroundColor: controller.isDark
                              ? DarkColors.text2
                              : LightColors.text2,
                          side: controller.isDark
                              ? BorderSide.none
                              : BorderSide(color: LightColors.border),
                          fixedSize: Size(AppSizes.w34, AppSizes.h34),
                        ),
                        icon: SvgPicture.asset(
                          controller.isDark
                              ? "assets/icons/sun.svg"
                              : "assets/icons/moon.svg",
                          width: AppSizes.w22,
                          height: AppSizes.h22,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
    );
  }
}
