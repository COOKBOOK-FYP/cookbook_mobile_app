import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/controllers/Post/post_controller.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_events_states.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitialState()) {
    // First we need to put the image into the firebase storage
    // Then submit a post to the firestore.
    on<PostSubmitEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final image = await PostController.uploadImageToStorageAndGet(
          event.compressedImage,
          event.postId,
        );

        // now submit post
        await PostController.submitPost(
          RecipeModel(
            createdAt: Timestamp.now(),
            description: event.description,
            // likes: 0,
            image: image,
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            postId: event.postId,
            category: event.category,
            ownerName: event.ownerName,
            ownerPhotoUrl: event.ownerPhotoUrl,
          ),
        );

        emit(PostSubmittedState());
      } catch (e) {
        emit(PostErrorState(message: e.toString()));
      }
    });
  }
}
