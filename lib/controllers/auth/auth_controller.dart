import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/controllers/Firebase/firebase_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static Future<void> createUser(
    String userId, {
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? postCount,
    String? followersCount,
    String? followingCount,
    String? bio,
    String? likes,
    String? country,
    Timestamp? dateOfBirth,
  }) async {
    final userCollection =
        await FirebaseContants.usersCollection.doc(userId).get();
    if (!userCollection.exists) {
      userCollection.reference.set(
        {
          'userId': userId,
          'createdAt': Timestamp.now(),
          'updatedAt': Timestamp.now(),
          'firstName': firstName,
          'lastName': lastName,
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
          'photoUrl': photoUrl ?? '',
          'postCount': postCount ?? 0,
          'followersCount': followersCount ?? 0,
          'followingCount': followingCount ?? 0,
          'bio': bio ?? 'Hey there! I am using CookBook',
          'likes': likes ?? 0,
          'country': country ?? '',
          'dateOfBirth': dateOfBirth ?? DateTime.now(),
        },
      );
      // FirebaseContants.usersCollection.doc(userId).set(
      //   {
      //     'userId': userId,
      //     'createdAt': Timestamp.now(),
      //     'updatedAt': Timestamp.now(),
      //     'firstName': firstName,
      //     'lastName': lastName,
      //     'email': email,
      //     'phoneNumber': phoneNumber,
      //     'photoUrl': photoUrl ?? '',
      //     'postCount': postCount ?? 0,
      //     'followersCount': followersCount ?? 0,
      //     'followingCount': followingCount ?? 0,
      //     'bio': bio ?? 'Hey there! I am using CookBook',
      //     'likes': likes ?? 0,
      //     'location': location ?? '',
      //     'dateOfBirth': dateOfBirth ?? DateTime.now(),
      //   },
      // );
    }
  }

  static Future<void> completeProfile({
    required String bio,
    required String country,
    required String dateOfBirth,
    required String photoUrl,
  }) async {
    try {
      final userDoc = await FirebaseController.getUsersCollection(
        FirebaseAuth.instance.currentUser!.uid,
      );

      if (userDoc.exists) {
        // update the userDoc
        userDoc.reference.update(
          {
            "country": country,
            "bio": bio,
            "dateOfBirth": dateOfBirth,
            "photoUrl": photoUrl,
          },
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteUser(String userId) async {
    FirebaseAuth.instance.currentUser!.delete().then((account) async {
      final userDocument =
          await FirebaseContants.usersCollection.doc(userId).get();
      if (userDocument.exists) {
        FirebaseContants.usersCollection.doc(userId).delete();
      }
    }).catchError((error) {});
  }

  static Future<void> updateUser(
    String userId, {
    String? firstName,
    String? lastName,
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
          'firstName': firstName,
          'lastName': lastName,
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
}
