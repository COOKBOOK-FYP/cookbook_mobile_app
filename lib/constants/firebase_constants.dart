import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseContants {
  // Google sign in constants //
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final googleUid = FirebaseContants.googleSignIn.currentUser!.id;

  // Firebase constants //
  static String uid = FirebaseAuth.instance.currentUser!.uid;
  static final usersCollection = FirebaseFirestore.instance.collection('Users');
}
