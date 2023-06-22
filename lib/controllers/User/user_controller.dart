import 'package:cookbook/constants/firebase_constants.dart';

class UserController {
  static void createUser(
    String userId, {
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
  }) {
    FirebaseContants.usersCollection.doc(userId).set({
      'userId': userId,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'displayName': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    });
  }

  static void updateUser(String userId) {}
}
