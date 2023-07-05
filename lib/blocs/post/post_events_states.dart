part of 'post_bloc.dart';

// Events

abstract class PostEvent {}

class PostSubmitEvent extends PostEvent {
  final File compressedImage;
  final String postId;
  final String description;
  final String category;
  PostSubmitEvent({
    required this.compressedImage,
    required this.postId,
    required this.description,
    required this.category,
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
