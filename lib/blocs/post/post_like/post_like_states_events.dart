part of 'post_like_bloc.dart';

// Events
abstract class PostLikeEvent {}

class PostLikeOnClickEvent extends PostLikeEvent {
  final RecipeModel post;
  final bool isPostLiked;

  PostLikeOnClickEvent(this.post, this.isPostLiked);
}

// States
abstract class PostLikeState {}

class PostLikeInitialState extends PostLikeState {}

class PostLikeLoadingState extends PostLikeState {}

class PostLikeSuccessState extends PostLikeState {}

class PostLikeFailureState extends PostLikeState {
  final String errorMessage;

  PostLikeFailureState(this.errorMessage);
}

class PostLikeNetworkErrorState extends PostLikeState {}
