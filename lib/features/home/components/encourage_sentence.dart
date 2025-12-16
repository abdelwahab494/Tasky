import 'package:tasky/core/imports.dart';

class EncourageSentence extends StatelessWidget {
  const EncourageSentence({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Yuhuu ,Your work Is",
          style: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: 32, letterSpacing: 0.5),
          textAlign: TextAlign.left,
        ),
        Row(
          children: [
            Text(
              "almost done !  ",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 32,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.left,
            ),
            SvgPicture.asset("assets/images/welcome icon.svg"),
          ],
        ),
      ],
    );
  }
}
