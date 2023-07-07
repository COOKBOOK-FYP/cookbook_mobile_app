part of 'post_bloc.dart';

// Events

abstract class PostEvent {}

class PostSubmitEvent extends PostEvent {
  final File compressedImage;
  final String postId;
  final String description;
  final String category;
  final String ownerName;
  final String ownerPhotoUrl;
  PostSubmitEvent({
    required this.compressedImage,
    required this.postId,
    required this.description,
    required this.category,
    required this.ownerName,
    required this.ownerPhotoUrl,
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
