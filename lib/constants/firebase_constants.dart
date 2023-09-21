import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseContants {
  // Google sign in constants //
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final googleUid = FirebaseContants.googleSignIn.currentUser!.id;

  // Push notifications
  static String? fcmToken;

  // Firebase constants //
  static String uid = FirebaseAuth.instance.currentUser!.uid;
  static final usersCollection = FirebaseFirestore.instance.collection('Users');
  static final recipesCollection =
      FirebaseFirestore.instance.collection('Recipes');
  static final commentsCollection =
      FirebaseFirestore.instance.collection('Comments');
  static final likesCollection = FirebaseFirestore.instance.collection('Likes');
  static final feedCollection = FirebaseFirestore.instance.collection('Feed');
  static final followersCollection =
      FirebaseFirestore.instance.collection('Followers');
  static final followingCollection =
      FirebaseFirestore.instance.collection('Followings');

  static final pushNotificationColletion =
      FirebaseFirestore.instance.collection('PushNotifications');
  // Storage constants //
  static final storageRef = FirebaseStorage.instance.ref();
}
