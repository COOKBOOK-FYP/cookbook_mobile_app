import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Notification/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationController {
  static Future<List<NotificationModel>>
      getNotificationsForCurrentUser() async {
    List<NotificationModel> notifications = [];
    try {
      final notificationData = await FirebaseContants.feedCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();
      if (notificationData.docs.isEmpty) {
        return notifications;
      } else {
        for (var comment in notificationData.docs) {
          notifications.add(NotificationModel.fromJson(comment.data()));
        }
        return notifications;
      }
    } catch (error) {
      rethrow;
    }
  }
}
