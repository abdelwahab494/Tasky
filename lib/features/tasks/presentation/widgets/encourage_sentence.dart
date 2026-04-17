import 'package:tasky/core/imports.dart';

class EncourageSentence extends StatelessWidget {
  const EncourageSentence({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.encourage.firstSentence,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: AppSizes.sp32,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Row(
                  children: [
                    Text(
                      state.encourage.secSentence,
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(
                            fontSize: AppSizes.sp32,
                            letterSpacing: 0.5,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    SvgPicture.asset(AppAssets.imagesWelcomeIcon),
                  ],
                ),
              ],
            ).animate().fadeIn(duration: const Duration(milliseconds: 130));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
