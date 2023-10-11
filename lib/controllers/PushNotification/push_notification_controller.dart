import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationController {
  static var messaging = FirebaseMessaging.instance;
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initLocalNotifications(
    BuildContext context,
    RemoteMessage message,
  ) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings settings = const InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        debugPrint('notification received');
      },
    );
  }

  static void requestPermissions() async {
    var notificationSettings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    // handle different states
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      debugPrint('user has accepted the permissions');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('user has accepted the provisional permissions');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) {
      debugPrint('user has denied the permissions');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      debugPrint('user has not yet accepted the permissions');
    }
  }

  static void listenMessages(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification?.title.toString());
      debugPrint(message.notification?.body.toString());

      // whenever you listen for new notifications, just show it
      showNotifications(context, message);
    });
  }

  static void showNotifications(
    BuildContext context,
    RemoteMessage message,
  ) async {
    // the very first thing that we need to do is to initialize the
    // local notifications plugin
    initLocalNotifications(context, message);
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      'High Importance Notifications',
      importance: Importance.max,
    );
    // Android details
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    // IOS Details
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    // The actual details
    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    // The actual code to show notifications
    Future.delayed(Duration.zero, () {
      _localNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        platformDetails,
      );
    });
  }

  static Future<String> getFcmToken() async {
    String? token = await messaging.getToken();

    // Refresh the token, if it is updated
    if (refreshToken() != null) {
      token = refreshToken();
      // update firestore...
    }
    return token!;
  }

  static String? refreshToken() {
    String? token;
    messaging.onTokenRefresh.listen((newToken) {
      debugPrint('token refreshed');
      token = newToken;
    });
    return token;
  }
}




// FirebaseContants.pushNotificationColletion
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update({
//         "fcmToken": token,
//         "updated_at": Timestamp.now(),
//       });

