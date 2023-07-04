part of 'complete_profile_bloc.dart';

// States
abstract class CompleteProfileState {}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileLoading extends CompleteProfileState {}

class CompleteProfileSuccess extends CompleteProfileState {}

class CompleteProfileFailed extends CompleteProfileState {
  final String error;

  CompleteProfileFailed({required this.error});
}

// Events
abstract class CompleteProfileEvent {}

class CompleteProfileEventSubmit extends CompleteProfileEvent {
  final String bio;
  final String country;
  final String dateOfBirth;

  CompleteProfileEventSubmit({
    required this.bio,
    required this.country,
    required this.dateOfBirth,
  });
}
