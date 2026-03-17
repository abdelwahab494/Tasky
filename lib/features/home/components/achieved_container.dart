import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class AchievedContainer extends StatelessWidget {
  const AchievedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return context.watch<HomeController>().tasksList.isNotEmpty
        ? Skeletonizer(
            enabled: context.watch<HomeController>().isLoading,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: AppSizes.h75),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h8,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.r20),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Achieved Tasks",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Gap(AppSizes.h4),
                          Consumer<HomeController>(
                            builder:
                                (
                                  BuildContext context,
                                  HomeController value,
                                  Widget? child,
                                ) => Text(
                                  "${value.completedTasksList.length} Out of ${value.tasksList.length} Done",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                          ),
                        ],
                      ),
                      Selector<HomeController, int>(
                        selector:
                            (BuildContext context, HomeController value) =>
                                value.percentage,
                        builder:
                            (BuildContext context, int value, Widget? child) {
                              return CircularPercentIndicator(
                                    radius: AppSizes.r27,
                                    lineWidth: 5,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    animationDuration: 700,
                                    percent: value / 100,
                                    progressColor: Theme.of(
                                      context,
                                    ).primaryColor,
                                    backgroundColor: DarkColors.text4
                                        .withOpacity(0.2),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: Text(
                                      "$value%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: AppSizes.sp18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  )
                                  .animate(
                                    delay: 500.ms,
                                    onPlay: (controller) =>
                                        controller.repeat(reverse: true),
                                  )
                                  .then(delay: const Duration(seconds: 5))
                                  .shake(hz: 2, rotation: 0.09);
                            },
                      ),
                    ],
                  ).animate().fadeIn(duration: const Duration(milliseconds: 150)),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
