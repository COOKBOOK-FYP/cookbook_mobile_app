part of 'fetch_post_bloc.dart';

abstract class FetchPostState {}

class FetchPostInitialState extends FetchPostState {}

class FetchPostLoadingState extends FetchPostState {}

class FetchPostEmptyState extends FetchPostState {}

class FetchPostErrorState extends FetchPostState {
  final String message;
  FetchPostErrorState({required this.message});
}

class FetchPostNoInternetState extends FetchPostState {}

class FetchPostLoadedState extends FetchPostState {
  final List<RecipeModel> posts;

  FetchPostLoadedState({required this.posts});
}

// Events
abstract class FetchPostEvent {}

class FetchCurrentPosts extends FetchPostEvent {
  final int paginatedBy;
  FetchCurrentPosts(this.paginatedBy);
}

class FetchAllPosts extends FetchPostEvent {
  final int paginatedBy;
  FetchAllPosts(this.paginatedBy);
}
