part of 'comments_bloc.dart';

abstract class CommentsEvent {}

class CommentsAddEvent extends CommentsEvent {
  final String postId;
  final CommentModel comment;

  CommentsAddEvent({required this.comment, required this.postId});
}

class CommentsGetDataEvent extends CommentsEvent {
  final String postId;

  CommentsGetDataEvent({required this.postId});
}

class CommentsState {}

class CommentsInitialState extends CommentsState {}

class CommentsLoadingState extends CommentsState {}

class CommentsAddedState extends CommentsState {}

class CommentsLoadedState extends CommentsState {
  final List<CommentModel> comments;

  CommentsLoadedState({required this.comments});
}

class CommentsErrorState extends CommentsState {
  final String message;

  CommentsErrorState({required this.message});
}

class CommentsEmptyState extends CommentsState {}

class CommentsNoInternetState extends CommentsState {}
