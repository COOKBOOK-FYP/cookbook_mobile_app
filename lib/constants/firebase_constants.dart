import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseContants {
  // Google sign in constants //
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  // Firebase constants //

  static final usersCollection = FirebaseFirestore.instance.collection('Users');
}
