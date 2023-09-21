import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationController {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static void requestNotificationPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<String?> getFCMToken() async {
    String? token = await firebaseMessaging.getToken();
    return token;
  }

  static void isTokenRefreshed() {
    firebaseMessaging.onTokenRefresh.listen((token) {
      FirebaseContants.fcmToken = token;
      // update firestore as well
      FirebaseContants.pushNotificationColletion
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "fcmToken": token,
        "updated_at": Timestamp.now(),
      });
    });
  }
}
