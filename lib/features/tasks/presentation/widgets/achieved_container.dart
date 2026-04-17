import 'package:tasky/core/imports.dart';

class AchievedContainer extends StatelessWidget {
  const AchievedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      buildWhen: (previous, current) => current is TasksLoaded,
      builder: (context, state) {
        if (state is TasksLoaded) {
          if (state.tasksList.isEmpty) {
            return const SliverToBoxAdapter();
          }
          final int percentage =
              ((state.tasksList.isEmpty
                          ? 0.0
                          : (state.doneTasks.length / state.tasksList.length)
                                .clamp(0.0, 1.0)) *
                      100)
                  .round();
          return SliverAppBar(
            pinned: state.tasksList.isNotEmpty,
            collapsedHeight: AppSizes.h80,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: AppSizes.h8),
              expandedTitleScale: 1,
              title: ConstrainedBox(
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
                            Text(
                              "${state.doneTasks.length} Out of ${state.tasksList.length} Done",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                              radius: AppSizes.r27,
                              lineWidth: 5,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 700,
                              percent: percentage / 100,
                              progressColor: Theme.of(context).primaryColor,
                              backgroundColor: DarkColors.text4.withOpacity(
                                0.2,
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                "$percentage%",
                                style: Theme.of(context).textTheme.titleMedium!
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
                            .shake(hz: 2, rotation: 0.09),
                      ],
                    ).animate().fadeIn(duration: const Duration(milliseconds: 150)),
                  ),
                ),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
