import 'dart:io';

import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class PostController {
  static Future<String> uploadImageToStorageAndGet(
      File compressedImage, String postId) async {
    final storageReference = FirebaseStorage.instance.ref();
    final uploadTask =
        storageReference.child('posts/$postId.jpg').putFile(compressedImage);
    final taskSnapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // now submit post
  static Future<void> submitPost(RecipeModel recipe) async {
    // recipe id
    final recipeId = const Uuid().v4();
    try {
      await FirebaseContants.recipesCollection
          .doc(recipeId)
          .set(recipe.toJson());
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<RecipeModel>> fetchPosts() async {
    List<RecipeModel> recipes = [];
    try {
      final posts = await FirebaseContants.recipesCollection.get();
      for (var post in posts.docs) {
        recipes.add(RecipeModel.fromJson(post.data()));
      }
      return recipes;
    } catch (error) {
      rethrow;
    }
  }
}
