import 'dart:io';

import 'package:cookbook/controllers/Post/post_controller.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_post_states_events.dart';

class FetchPostBloc extends Bloc<FetchPostEvent, FetchPostState> {
  FetchPostBloc() : super(FetchPostInitialState()) {
    on<FetchPostGetDataEvent>((event, emit) async {
      List<RecipeModel> posts = [];
      emit(FetchPostLoadingState());
      try {
        posts = await PostController.fetchPosts(event.paginatedBy);

        if (posts.isEmpty) {
          emit(FetchPostEmptyState());
        } else {
          emit(FetchPostLoadedState(posts: posts));
        }
      } catch (error) {
        if (error is SocketException) {
          emit(FetchPostErrorState(message: 'No internet connection'));
        } else if (error is HttpException) {
          emit(FetchPostErrorState(message: 'No service found'));
        } else {
          emit(FetchPostErrorState(message: error.toString()));
        }
      }
    });
  }
}
