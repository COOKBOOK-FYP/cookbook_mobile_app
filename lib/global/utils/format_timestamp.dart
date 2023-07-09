import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  final dateTime = timestamp.toDate();
  final now = DateTime.now();

  if (dateTime.year == now.year) {
    if (dateTime.month == now.month && dateTime.day == now.day) {
      final diff = now.difference(dateTime);
      if (diff.inMinutes < 1) {
        return 'just now';
      } else if (diff.inHours < 1) {
        return '${diff.inMinutes} ${diff.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return '${diff.inHours} ${diff.inHours == 1 ? 'hour' : 'hours'} ago';
      }
    } else {
      final formatter = DateFormat('dd MMM');
      return formatter.format(dateTime);
    }
  } else {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(dateTime);
  }
}
