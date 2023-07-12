import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class PostController {
  static Future<String> uploadImageToStorageAndGet(
      File compressedImage, String postId,
      {child}) async {
    final storageReference = FirebaseStorage.instance.ref();
    final uploadTask = child ??
        storageReference.child('posts/$postId.jpg').putFile(compressedImage);
    final taskSnapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // now submit post
  static Future<void> submitPost(RecipeModel recipe) async {
    // recipe id
    final postId = const Uuid().v4();
    try {
      await FirebaseContants.recipesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("UserPosts")
          .doc(postId)
          .set(
            recipe.toJson(),
          );
      // update post count in user collection for the current user
      await FirebaseContants.usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'postCount': FieldValue.increment(1),
        },
      );
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<RecipeModel>> fetchCurrentUserPosts(
      int paginatedBy) async {
    List<RecipeModel> recipes = [];
    try {
      final posts = await FirebaseContants.recipesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("UserPosts")
          .orderBy('createdAt', descending: true)
          .get();
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

  // fetch all posts
  static Future<List<RecipeModel>> fetchAllPosts(int paginatedBy) async {
    List<RecipeModel> recipes = [];
    try {
      final posts = await FirebaseContants.recipesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("UserPosts")
          .orderBy('createdAt', descending: true)
          .get();
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

  Future<int> countPostLikes(likes) async {
    int count = 0;
    if (likes == null) {
      return count;
    }
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }
}
