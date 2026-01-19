import 'package:tasky/core/imports.dart';

class SliverCustomAppbar extends StatelessWidget {
  const SliverCustomAppbar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverAppBar(
          title: Text(
            title,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          titleSpacing: 0,
          toolbarHeight: 40,
        ),
        const SliverGap(20),
      ],
    );
  }
}
