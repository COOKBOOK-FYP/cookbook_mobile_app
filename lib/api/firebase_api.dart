// import 'package:firebase_messaging/firebase_messaging.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   // print title
//   print(message.notification!.title);
//   // print body
//   print(message.notification!.body);
//   // print data
//   print(message.data);
// }

// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//   }

//   Future initPushNotification() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       handleMessage(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       handleBackgroundMessage(message);
//     });
//   }

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fcmToken = await _firebaseMessaging.getToken();
//     print('fcmToken: $fcmToken');
//     initPushNotification();
//   }
// }
