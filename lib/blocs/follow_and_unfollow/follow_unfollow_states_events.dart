part of 'follow_unfollow_bloc.dart';

abstract class FollowUnfollowEvent {}

class FollowUnfollowFollowEvent extends FollowUnfollowEvent {
  final String otherUserId;
  FollowUnfollowFollowEvent({required this.otherUserId});
}

class FollowUnfollowUnfollowEvent extends FollowUnfollowEvent {
  final String otherUserId;
  FollowUnfollowUnfollowEvent({required this.otherUserId});
}

// States for follow and unfollow
abstract class FollowUnfollowState {}

class FollowUnfollowInitialState extends FollowUnfollowState {}

class FollowUnfollowLoadingState extends FollowUnfollowState {}

class FollowUnfollowTrueState extends FollowUnfollowState {}

class FollowUnfollowFalseState extends FollowUnfollowState {}

class FollowUnfollowFailureState extends FollowUnfollowState {
  final String errorMessage;
  FollowUnfollowFailureState({required this.errorMessage});
}
