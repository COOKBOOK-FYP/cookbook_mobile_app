import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';

class FirebaseController {
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUsersCollection(
    String uid,
  ) async {
    return FirebaseContants.usersCollection.doc(uid).get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>>
      getRecipesCollection() async {
    return FirebaseContants.recipesCollection.get();
  }
}
