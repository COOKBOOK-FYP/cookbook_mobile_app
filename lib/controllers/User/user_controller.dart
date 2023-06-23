import 'package:cookbook/constants/firebase_constants.dart';

class UserController {
  static void createUser(
    String userId, {
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
  }) {
    FirebaseContants.usersCollection.doc(userId).set({
      'userId': userId,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'displayName': displayName ?? "",
      'email': email,
      'phoneNumber': phoneNumber ?? "",
      'photoUrl': photoUrl ?? "",
      'postCount': 0,
      'followersCount': 0,
      'followingCount': 0,
      'bio': "",
      'likes': "",
    });
  }

  static void updateUser(String userId) {
    FirebaseContants.usersCollection.doc(userId).update({
      'updatedAt': DateTime.now(),
    });
  }
}
