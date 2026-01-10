import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class EncourageSentence extends StatelessWidget {
  const EncourageSentence({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Selector<HomeController, bool>(
        selector: (BuildContext context, HomeController controller) =>
            controller.isLoading,
        builder: (BuildContext context, bool value, Widget? child) {
          return Skeletonizer(
            enabled: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Yuhuu ,Your work Is",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 32,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                Row(
                  children: [
                    Text(
                      "almost done !  ",
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(fontSize: 32, letterSpacing: 0.5),
                      textAlign: TextAlign.left,
                    ),
                    if (!context.watch<HomeController>().isLoading)
                      SvgPicture.asset("assets/images/welcome icon.svg"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
