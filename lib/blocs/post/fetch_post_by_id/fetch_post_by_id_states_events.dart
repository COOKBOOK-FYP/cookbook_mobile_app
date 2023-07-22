part of 'fetch_post_by_id_bloc.dart';

abstract class FetchPostByIdEvent {}

class FetchPostByIdGetDataEvent extends FetchPostByIdEvent {
  final String postId;
  FetchPostByIdGetDataEvent(this.postId);
}

abstract class FetchPostByIdState {}

class FetchPostByIdInitialState extends FetchPostByIdState {}

class FetchPostByIdLoadingState extends FetchPostByIdState {}

class FetchPostByIdLoadedState extends FetchPostByIdState {
  final RecipeModel recipeModel;
  FetchPostByIdLoadedState(this.recipeModel);
}

class FetchPostByIdErrorState extends FetchPostByIdState {
  final String message;
  FetchPostByIdErrorState(this.message);
}
