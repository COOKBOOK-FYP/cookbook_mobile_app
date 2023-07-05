part of 'post_bloc.dart';

// Events

abstract class PostEvent {}

class PostSubmitEvent extends PostEvent {
  final File compressedImage;
  final String postId;
  final String description;
  PostSubmitEvent({
    required this.compressedImage,
    required this.postId,
    required this.description,
  });
}

// States

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostSubmittedState extends PostState {}

class PostErrorState extends PostState {
  final String message;
  PostErrorState({required this.message});
}
