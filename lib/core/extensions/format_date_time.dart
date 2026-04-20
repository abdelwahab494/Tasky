import 'package:intl/intl.dart';

extension DateTimeFormatterExtension on DateTime {
  String formatDate({FormatDateEnum formatType = FormatDateEnum.difference}) {
    final date = DateFormat('yyyy-MM-dd').format(this);
    final time = DateFormat('h:mm a').format(this);
    final diff = DateTime.now().difference(this);

    switch (formatType) {
      case FormatDateEnum.dateOnly:
        return date;
      case FormatDateEnum.dateTime:
        return "$date • $time";
      case FormatDateEnum.difference:
        if (diff.inMinutes < 60) {
          return "${diff.inMinutes} min ago";
        } else if (diff.inHours < 24) {
          return "${diff.inHours} hours ago";
        } else if (diff.inDays < 7) {
          return "${diff.inDays} days ago";
        } else if (diff.inDays < 30) {
          final weeks = diff.inDays ~/ 7;
          return weeks == 1 ? "1 week ago" : "$weeks weeks ago";
        } else {
          return date;
        }
    }
  }
}

enum FormatDateEnum { dateOnly, dateTime, difference }
