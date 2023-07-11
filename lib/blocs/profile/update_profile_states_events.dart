part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent {}

class UpdateProfileOnChangedEvent extends UpdateProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? photoUrl;
  final String? country;

  UpdateProfileOnChangedEvent({
    this.firstName,
    this.lastName,
    this.bio,
    this.phoneNumber,
    this.dateOfBirth,
    this.photoUrl,
    this.country,
  });
}

// States
abstract class UpdateProfileState {}

class UpdateProfileInitialState extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileSuccessState extends UpdateProfileState {
  final String message;

  UpdateProfileSuccessState({this.message = 'Profile updated successfully'});
}

class UpdateProfileErrorState extends UpdateProfileState {
  final String message;

  UpdateProfileErrorState({this.message = 'Error updating profile'});
}

class UpdateProfileNoInternetState extends UpdateProfileState {}
