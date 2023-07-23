import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Notification/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  static Future<bool> followFollowers(String otherUserId) async {
    try {
      await FirebaseContants.followersCollection
          .doc(otherUserId)
          .collection("userFollowers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "createdAt": Timestamp.now(),
      });

      // put that user in your following collection
      await FirebaseContants.followingCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userFollowing")
          .doc(otherUserId)
          .set({
        "userId": otherUserId,
        "createdAt": Timestamp.now(),
      });

      if (FirebaseAuth.instance.currentUser!.uid != otherUserId) {
        await FirebaseContants.feedCollection
            .doc(otherUserId)
            .collection("notifications")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(
              NotificationModel(
                type: "follow",
                createdAt: Timestamp.now(),
                userId: FirebaseAuth.instance.currentUser!.uid,
              ).toJson(),
            );
      }
      return true;
    } catch (_) {
      rethrow;
    }
  }

  static Future<bool> unfollowFollowers(String otherUserId) async {
    try {
      await FirebaseContants.followersCollection
          .doc(otherUserId)
          .collection("userFollowers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          await value.reference.delete();
        }
      });

      await FirebaseContants.followingCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userFollowing")
          .doc(otherUserId)
          .get()
          .then((value) async {
        if (value.exists) {
          await value.reference.delete();
        }
      });

      // delete notification for them
      await FirebaseContants.feedCollection
          .doc(otherUserId)
          .collection("notifications")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          await value.reference.delete();
        }
      });
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
