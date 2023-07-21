import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'post_like_states_events.dart';

class PostLikeBloc extends Bloc<PostLikeEvent, PostLikeState> {
  PostLikeBloc() : super(PostLikeInitialState()) {
    on<PostLikeOnClickEvent>((event, emit) async {
      emit(PostLikeLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(PostLikeNetworkErrorState());
        } else {
          if (event.isPostLiked == true) {
            event.post.likes?.remove(FirebaseAuth.instance.currentUser!.uid);
            event.post.likeCount = event.post.likeCount! - 1;
            FirebaseContants.usersCollection.doc(event.post.ownerId).update({
              'like': FieldValue.increment(-1),
            });

            FirebaseFirestore.instance
                .collection("FeedPosts")
                .doc(event.post.postId)
                .update({
              'likes': event.post.likes,
              'likeCount': FieldValue.increment(-1),
            });
          } else {
            event.post.likes?[FirebaseAuth.instance.currentUser!.uid] = true;
            event.post.likeCount = event.post.likeCount! + 1;
            // increment likes in the user collection
            FirebaseContants.usersCollection.doc(event.post.ownerId).update({
              'like': FieldValue.increment(1),
            });

            FirebaseFirestore.instance
                .collection("FeedPosts")
                .doc(event.post.postId)
                .update({
              'likes': event.post.likes,
              'likeCount': FieldValue.increment(1),
            });
          }
          emit(PostLikeSuccessState());
        }
      } catch (error) {
        emit(PostLikeFailureState(error.toString()));
      }
    });
  }
}
