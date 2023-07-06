import 'dart:io';

import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

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

  static Future<List<RecipeModel>> fetchPosts(int paginatedBy) async {
    List<RecipeModel> recipes = [];
    try {
      final posts = await FirebaseContants.recipesCollection.get();
      if (posts.docs.isEmpty) {
        return recipes;
      } else if (posts.docs.length < paginatedBy) {
        // if posts are less than paginatedBy
        for (var post in posts.docs) {
          recipes.add(RecipeModel.fromJson(post.data()));
        }
        return recipes;
      } else if (posts.docs.length == paginatedBy) {
        // if posts are equal to paginatedBy
        for (var post in posts.docs) {
          recipes.add(RecipeModel.fromJson(post.data()));
        }
        return recipes;
      } else if (posts.docs.length > paginatedBy) {
        // if posts are greater than paginatedBy
        final getSomePosts = posts.docs.pickSome(paginatedBy);
        for (var post in getSomePosts) {
          recipes.add(RecipeModel.fromJson(post.data()));
        }
      }
      return recipes;
    } catch (error) {
      return recipes;
    }
  }
}
