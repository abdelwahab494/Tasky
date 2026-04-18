import 'package:tasky/core/imports.dart';

class TaskEmptyView extends StatelessWidget {
  const TaskEmptyView({
    super.key,
    required this.svgPath,
    required this.title,
    required this.subTitle,
  });
  final String svgPath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: FittedBox(
          child: SizedBox(
            width: AppSizes.w160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSizes.w60,
                      AppSizes.h0,
                      AppSizes.w60,
                      AppSizes.h20,
                    ),
                    child: SvgPicture.asset(
                      svgPath,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                      width: AppSizes.w250,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: AppSizes.sp500,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    subTitle,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: AppSizes.sp500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
