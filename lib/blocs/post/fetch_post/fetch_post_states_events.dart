part of 'fetch_post_bloc.dart';

abstract class FetchPostState {}

class FetchPostInitialState extends FetchPostState {}

class FetchPostLoadingState extends FetchPostState {}

class FetchPostEmptyState extends FetchPostState {}

class FetchPostErrorState extends FetchPostState {
  final String message;
  FetchPostErrorState({required this.message});
}

class FetchPostLoadedState extends FetchPostState {
  final List<RecipeModel> posts;

  FetchPostLoadedState({required this.posts});
}

// Events
abstract class FetchPostEvent {}

class FetchPostGetDataEvent extends FetchPostEvent {}
