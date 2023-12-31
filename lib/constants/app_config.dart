import 'package:cookbook/constants/firebase_constants.dart';

class AppConfig {
  static int searchUserPagenateCount = 50;
  static int recipesPostPagenatedCount = 100;

  static Future<int> recipesPostMaxCount() async {
    final recipesCollection = await FirebaseContants.recipesCollection.get();
    return recipesCollection.docs.length;
  }

// Adjust this value to control the position to trigger loading
  static double loadOnScrollHeight = 10000.0;
}
