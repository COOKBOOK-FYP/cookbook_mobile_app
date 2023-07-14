import 'dart:io';

import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/controllers/Post/post_controller.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

class FetchAllPostsBloc extends Bloc<FetchPostEvent, FetchPostState> {
  FetchAllPostsBloc() : super(FetchPostInitialState()) {
    on<FetchAllPosts>((event, emit) async {
      List<RecipeModel> posts = [];
      emit(FetchPostLoadingState());
      bool connectionValue = await isNetworkAvailable();
      if (connectionValue) {
        try {
          posts = await PostController.fetchAllPosts(event.paginatedBy);
          if (posts.isEmpty) {
            emit(FetchPostEmptyState());
          } else {
            emit(FetchPostLoadedState(posts: posts));
          }
        } catch (error) {
          if (error is SocketException) {
            emit(FetchPostNoInternetState());
          } else if (error is HttpException) {
            emit(FetchPostErrorState(message: 'No service found'));
          } else {
            emit(FetchPostErrorState(message: error.toString()));
          }
        }
      } else {
        emit(FetchPostNoInternetState());
      }
    });
  }
}
