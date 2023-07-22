import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    try {
      await FirebaseContants.recipesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("UserPosts")
          .doc(recipe.postId)
          .set(
            recipe.toJson(),
          );

      await FirebaseFirestore.instance
          .collection("FeedPosts")
          .doc(recipe.postId)
          .set(
            recipe.toJson(),
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
      final posts = await FirebaseFirestore.instance
          .collection("FeedPosts")
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

  static Future<void> likePost({
    required RecipeModel post,
    required bool isPostLiked,
  }) async {
    try {
      if (isPostLiked == true) {
        post.likes?.remove(FirebaseAuth.instance.currentUser!.uid);
        post.likeCount = post.likeCount! - 1;
        isPostLiked = false;
        FirebaseContants.usersCollection.doc(post.ownerId).update({
          'like': FieldValue.increment(-1),
        });

        FirebaseFirestore.instance
            .collection("FeedPosts")
            .doc(post.postId)
            .update({
          'likes': post.likes,
          'likeCount': FieldValue.increment(-1),
        });
      } else {
        post.likes?[FirebaseAuth.instance.currentUser!.uid] = true;
        post.likeCount = post.likeCount! + 1;
        isPostLiked = true;
        // increment likes in the user collection
        FirebaseContants.usersCollection.doc(post.ownerId).update({
          'likes': FieldValue.increment(1),
        });
        FirebaseFirestore.instance
            .collection("FeedPosts")
            .doc(post.postId)
            .update({
          'likes': post.likes,
          'likeCount': FieldValue.increment(1),
        });
      }
      await FirebaseContants.recipesCollection
          .doc(post.ownerId)
          .collection('UserPosts')
          .doc(post.postId)
          .update({
        'likes': post.likes,
        'likeCount': post.likeCount,
      });

      await FirebaseFirestore.instance
          .collection("FeedPosts")
          .doc(post.postId!)
          .update({
        'likes': post.likes,
        'likeCount': post.likeCount,
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<RecipeModel> fetchPostById(String postId) async {
    RecipeModel recipe = RecipeModel();
    try {
      final post = await FirebaseContants.recipesCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("UserPosts")
          .doc(postId)
          .get();
      if (post.exists) {
        recipe = RecipeModel.fromJson(post.data()!);
      }
      return recipe;
    } catch (error) {
      return recipe;
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
