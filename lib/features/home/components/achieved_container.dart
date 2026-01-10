import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class AchievedContainer extends StatelessWidget {
  const AchievedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Skeletonizer(
        enabled: context.watch<HomeController>().isLoading,
        // effect: ShimmerEffect(
        //   baseColor: Theme.of(context).colorScheme.outline,
        //   highlightColor: Theme.of(context).colorScheme.shadow,
        // ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achieved Tasks",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
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
                selector: (BuildContext context, HomeController value) =>
                    value.percentage,
                builder: (BuildContext context, int value, Widget? child) {
                  return CircularPercentIndicator(
                        radius: 27,
                        lineWidth: 5,
                        animation: true,
                        animateFromLastPercent: true,
                        animationDuration: 700,
                        percent: value / 100,
                        progressColor: Theme.of(context).primaryColor,
                        backgroundColor: DarkColors.text4.withOpacity(0.2),
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          "$value%",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      )
                      .animate(
                        delay: 500.ms,
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .then(delay: Duration(seconds: 5))
                      .shake(hz: 2, rotation: 0.09);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
