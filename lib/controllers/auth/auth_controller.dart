import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';

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
}