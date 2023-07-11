import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UpdateProfileController {
  static Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? bio,
    String? phoneNumber,
    String? dateOfBirth,
    String? photoUrl,
    String? country,
  }) async {
    await FirebaseContants.usersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "firstName": firstName,
      "lastName": lastName,
      "bio": bio,
      "phoneNumber": phoneNumber,
      "dateOfBirth": dateOfBirth,
      "photoUrl": photoUrl,
      "country": country,
      "fullName": "$firstName $lastName",
      "updatedAt": Timestamp.now(),
    });
    return true;
  }
}
