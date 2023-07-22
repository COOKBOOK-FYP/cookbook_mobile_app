import 'package:cookbook/controllers/Post/post_controller.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'fetch_post_by_id_states_events.dart';

class FetchPostByIdBloc extends Bloc<FetchPostByIdEvent, FetchPostByIdState> {
  FetchPostByIdBloc() : super(FetchPostByIdInitialState()) {
    on<FetchPostByIdGetDataEvent>((event, emit) async {
      emit(FetchPostByIdLoadingState());
      bool networkStatus = await isNetworkAvailable();
      if (networkStatus == true) {
        try {
          final recipe = await PostController.fetchPostById(event.postId);
          emit(FetchPostByIdLoadedState(recipe));
        } catch (error) {
          emit(FetchPostByIdErrorState(error.toString()));
        }
      } else {
        emit(FetchPostByIdErrorState("No Internet Connection"));
      }
    });
  }
}
