// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/main-tabs/notification/notification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

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
        handleAndroidPayload(context, message);
      },
      // onDidReceiveBackgroundNotificationResponse: (details) {
      //   debugPrint('notification received in background');
      //   handleAndroidPayload(context, message);
      // },
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
      // add fcm to the notification collection
      await FirebaseContants.pushNotificationColletion
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'fcmToken': await getFcmToken(),
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('user has accepted the provisional permissions');
      // add fcm to the notification collection
      await FirebaseContants.pushNotificationColletion
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'fcmToken': await getFcmToken(),
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
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

      if (Platform.isAndroid) {
        // the very first thing that we need to do is to initialize the
        // local notifications plugin
        initLocalNotifications(context, message);
        // whenever you listen for new notifications, just show it
        showNotifications(context, message);
      } else {
        showNotifications(context, message);
      }
    });
  }

  static void showNotifications(
    BuildContext context,
    RemoteMessage message,
  ) async {
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

  static void handleAndroidPayload(
      BuildContext context, RemoteMessage message) {
    var notificationBody = message.data;
    var notificationType = notificationBody['type'];

    switch (notificationType) {
      case 'post':
        // Navigate user to the notification page
        AppNavigator.goToPage(
          context: context,
          screen: const NotificationScreen(),
        );
        break;
      case 'follow':
        // Navigate user to the user profile
        print('follow');
        break;
      default:
        // Navigate user to the home page
        print('home');
        break;
    }
  }

  static Future<void> handlePayloadForTerminatedAndBackground(
      BuildContext context) async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleAndroidPayload(context, initialMessage);
    }

    // handle the notification tapped when the app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleAndroidPayload(context, message);
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

  static Future<void> sendNotification(
    String fcmToken, {
    required String body,
    required String type,
  }) async {
    const String authKey =
        'AAAA-Fu01VY:APA91bE_WYC0uyX7HiyHreAUrYupFZI7tUUdNIzE1jzFpHUkTgbumYmI89G5KaMGpqYbgVYrkrHN2PNDr7fwL6TT8wDTUUz6E1jXpfc1zEn-kGvHjQXqT8IODcAorTXqQRWz5L2a-FmU';
    // const String fcmToken =
    //     'dPHLxmBdT8Sc_QU7KpIwh9:APA91bH_ixHNGX6T2Nid6A395klvYDulERZwUa6eZktR08E5H-MnXxpZSS8C_V5tZbtWminJj_cMRyq-lMBYpOSkgEH38Ebyx_vnMd0frDPXMbkGK1jbDvD7x7bfyB3871rqI9oBEY3k';
    const headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=$authKey',
    };

    var data = {
      'to': fcmToken,
      'priority': 'high',
      'notification': {
        'title': 'Cookbook',
        'body': body,
      },
      // payload
      'data': {
        'type': 'follow',
      },
    };

    print('calling....::&&&&&&*********^^^^');

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      debugPrint('notification sent');
    } else {
      debugPrint('notification not sent');
    }
  }
}
