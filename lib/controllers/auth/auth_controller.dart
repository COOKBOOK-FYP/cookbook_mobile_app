import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static Future<void> createUser(
    String userId, {
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? postCount,
    String? followersCount,
    String? followingCount,
    String? bio,
    String? likes,
  }) async {
    FirebaseContants.usersCollection.doc(userId).set(
      {
        'userId': userId,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'displayName': displayName,
        'email': email,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl ?? '',
        'postCount': postCount ?? 0,
        'followersCount': followersCount ?? 0,
        'followingCount': followingCount ?? 0,
        'bio': bio ?? 'Hey there! I am using CookBook',
        'likes': likes ?? 0,
        'address': '',
      },
    );
  }

  static Future<void> updateUser(
    String userId, {
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? postCount,
    String? followersCount,
    String? followingCount,
    String? bio,
    String? likes,
  }) async {
    final userDocument =
        await FirebaseContants.usersCollection.doc(userId).get();

    if (userDocument.exists) {
      FirebaseContants.usersCollection.doc(userId).update(
        {
          'userId': userId,
          'updatedAt': Timestamp.now(),
          'displayName': displayName,
          'email': email,
          'phoneNumber': phoneNumber,
          'photoUrl': photoUrl ?? '',
          'postCount': postCount ?? 0,
          'followersCount': followersCount ?? 0,
          'followingCount': followingCount ?? 0,
          'bio': bio ?? 'Hey there! I am using CookBook',
          'likes': likes ?? 0,
          'address': '',
        },
      );
    }
  }

  static Future<void> signOut() async {
    await FirebaseContants.googleSignIn.signOut();
    FirebaseAuth.instance.authStateChanges();
    FirebaseAuth.instance.userChanges();
  }
}
