import 'package:tasky/core/imports.dart';

class HomeUserWelcome extends StatelessWidget {
  const HomeUserWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return SliverAppBar(
      toolbarHeight: AppSizes.h46,
      flexibleSpace: FlexibleSpaceBar(
        background: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksLoaded) {
              return Row(
                children: [
                  Gap(AppSizes.w8),
                  AvatarGlow(
                    glowRadiusFactor: 0.2,
                    glowColor: Theme.of(context).primaryColor,
                    startDelay: const Duration(seconds: 1),
                    child: CircleAvatar(
                      radius: AppSizes.r23,
                      backgroundImage: state.currentUser.imagePath == null
                          ? const AssetImage(AppAssets.imagesProfile)
                          : FileImage(File(state.currentUser.imagePath!)),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Gap(AppSizes.w11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Row(
                            spacing: AppSizes.w4,
                            children: [
                              Text(
                                s.hello,
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(letterSpacing: 0.5),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                state.currentUser.name,
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(letterSpacing: 0.5),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).animate().fadeIn(),
                            ],
                          ),
                        ),
                        Text(
                          state.currentUser.quote ??
                              s.onetaskatatimeOnestepcloser,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(letterSpacing: 0.25),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ).animate().fadeIn(),
                      ],
                    ),
                  ),
                  Gap(AppSizes.w11),
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
                              ? AppAssets.iconsSun
                              : AppAssets.iconsMoon,
                          width: AppSizes.w22,
                          height: AppSizes.h22,
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return Row(
              children: [
                Gap(AppSizes.w8),
                AvatarGlow(
                  glowRadiusFactor: 0.2,
                  glowColor: Theme.of(context).primaryColor,
                  startDelay: const Duration(seconds: 1),
                  child: CircleAvatar(
                    radius: AppSizes.r23,
                    backgroundImage: const AssetImage(AppAssets.imagesProfile),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Gap(AppSizes.w11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        s.hello,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(letterSpacing: 0.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        " \n ",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(letterSpacing: 0.25),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Gap(AppSizes.w11),
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
                            ? AppAssets.iconsSun
                            : AppAssets.iconsMoon,
                        width: AppSizes.w22,
                        height: AppSizes.h22,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
