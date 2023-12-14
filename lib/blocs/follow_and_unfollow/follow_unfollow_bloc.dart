import 'package:cookbook/controllers/User/user_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'follow_unfollow_states_events.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  FollowUnfollowBloc() : super(FollowUnfollowInitialState()) {
    on<FollowUnfollowFollowEvent>((event, emit) async {
      bool networkStatus = await isNetworkAvailable();
      if (networkStatus) {
        try {
          emit(FollowUnfollowLoadingState());

          final isFollow = await UserController.followFollowers(
            event.otherUserId,
          );
          if (isFollow) {
            emit(FollowUnfollowTrueState());
          } else {
            emit(FollowUnfollowFalseState());
          }
        } catch (error) {
          emit(FollowUnfollowFailureState(errorMessage: error.toString()));
        }
      } else {
        emit(FollowUnfollowFailureState(errorMessage: "No Internet"));
      }
    });
    on<FollowUnfollowUnfollowEvent>((event, emit) async {
      bool networkStatus = await isNetworkAvailable();
      if (networkStatus) {
        try {
          emit(FollowUnfollowLoadingState());

          final isUnfollow =
              await UserController.unfollowFollowers(event.otherUserId);
          if (isUnfollow) {
            emit(FollowUnfollowFalseState());
          } else {
            emit(FollowUnfollowTrueState());
          }
        } catch (error) {
          emit(FollowUnfollowFailureState(errorMessage: error.toString()));
        }
      } else {
        emit(FollowUnfollowFailureState(errorMessage: "No Internet"));
      }
    });
  }
}
