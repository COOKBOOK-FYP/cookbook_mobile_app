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
        posts = await PostController.fetchPosts();
        if (posts.isEmpty) {
          emit(FetchPostEmptyState());
        } else {
          emit(FetchPostLoadedState(posts: posts));
        }
      } catch (e) {
        emit(FetchPostErrorState(message: e.toString()));
      }
    });
  }
}
