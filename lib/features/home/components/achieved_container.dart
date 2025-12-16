import 'package:tasky/core/imports.dart';

class AchievedContainer extends StatefulWidget {
  const AchievedContainer({
    super.key,
    required this.completed,
    required this.total,
  });

  final int completed;
  final int total;

  @override
  State<AchievedContainer> createState() => _AchievedContainerState();
}

class _AchievedContainerState extends State<AchievedContainer>
    with TickerProviderStateMixin {
  late double percentage;

  @override
  void initState() {
    super.initState();
    percentage = widget.total == 0
        ? 0.0
        : (widget.completed / widget.total).clamp(0.0, 1.0);
  }

  @override
  void didUpdateWidget(covariant AchievedContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.completed != widget.completed ||
        oldWidget.total != widget.total) {
      setState(() {
        percentage = widget.total == 0
            ? 0.0
            : (widget.completed / widget.total).clamp(0.0, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int displayPercent = (percentage * 100).round();

    return Container(
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
              Text(
                "${widget.completed} Out of ${widget.total} Done",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          CircularPercentIndicator(
                radius: 27,
                lineWidth: 5,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 700,
                percent: percentage,
                progressColor: Theme.of(context).primaryColor,
                backgroundColor: DarkColors.text4.withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "$displayPercent%",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
              .animate(
                delay: 500.ms,
                onPlay: (controller) => controller.repeat(reverse: true),
              )
              .then(delay: Duration(seconds: 5))
              .shake(hz: 2, rotation: 0.09),
        ],
      ),
    );
  }
}
