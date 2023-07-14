import 'dart:io';

import 'package:cookbook/controllers/Comments/comments_controller.dart';
import 'package:cookbook/models/Comments/comment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'comments_states_events.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsInitialState()) {
    on<CommentsAddEvent>((event, emit) async {
      bool connectionValue = await isNetworkAvailable();
      if (!connectionValue) {
        emit(CommentsNoInternetState());
        return;
      }
      emit(CommentsLoadingState());
      try {
        await CommentsController.addComment(event.postId, event.comment);
        emit(CommentsAddedState());
      } catch (error) {
        emit(CommentsErrorState(message: error.toString()));
      }
    });

    on<CommentsGetDataEvent>((event, emit) async {
      List<CommentModel> comments = [];
      emit(CommentsLoadingState());
      bool connectionValue = await isNetworkAvailable();
      if (connectionValue) {
        try {
          comments = await CommentsController.getComments(event.postId);
          if (comments.isEmpty) {
            emit(CommentsEmptyState());
          } else {
            emit(CommentsLoadedState(comments: comments));
          }
        } catch (error) {
          if (error is SocketException) {
            emit(CommentsNoInternetState());
          } else if (error is HttpException) {
            emit(CommentsErrorState(message: 'No service found'));
          } else {
            emit(CommentsErrorState(message: error.toString()));
          }
        }
      } else {
        emit(CommentsNoInternetState());
      }
    });
  }
}
