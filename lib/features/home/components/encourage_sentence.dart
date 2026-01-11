import 'package:skeletonizer/skeletonizer.dart';
import 'package:tasky/core/imports.dart' hide ShimmerEffect;

class EncourageSentence extends StatelessWidget {
  const EncourageSentence({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child:
          Selector<
            HomeController,
            ({EncourageEnum? encourageEnum, bool isLoading})
          >(
            selector: (BuildContext context, HomeController controller) => (
              isLoading: controller.isLoading,
              encourageEnum: controller.encourageStatus,
            ),
            builder: (BuildContext context, data, Widget? child) {
              return Skeletonizer(
                enabled: data.isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.encourageEnum == EncourageEnum.isGoing
                          ? "Yuhuu! Your work Is"
                          : data.encourageEnum == EncourageEnum.isDone
                          ? "Awesome! Your work"
                          : "Let's go! Your work is",
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(fontSize: 32, letterSpacing: 0.5),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Text(
                          data.encourageEnum == EncourageEnum.isGoing
                              ? "almost done !  "
                              : data.encourageEnum == EncourageEnum.isDone
                              ? "is all done."
                              : "ready to begin.  ",
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
