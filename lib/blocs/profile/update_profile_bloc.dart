import 'dart:io';

import 'package:cookbook/controllers/Profile/update_profile_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_profile_states_events.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitialState()) {
    bool isUpdated = false;
    on<UpdateProfileOnChangedEvent>((event, emit) async {
      emit(UpdateProfileLoadingState());
      try {
        isUpdated = await UpdateProfileController.updateProfile(
          firstName: event.firstName,
          lastName: event.lastName,
          bio: event.bio,
          photoUrl: event.photoUrl,
          dateOfBirth: event.dateOfBirth,
          phoneNumber: event.phoneNumber,
          country: event.country,
        );
        if (!isUpdated) {
          emit(UpdateProfileErrorState(message: 'Profile not updated'));
        }

        emit(UpdateProfileSuccessState());
      } catch (error) {
        if (error is SocketException) {
          emit(UpdateProfileErrorState(message: 'No internet connection'));
        } else if (error is HttpException) {
          emit(UpdateProfileErrorState(message: 'No service found'));
        } else {
          emit(UpdateProfileErrorState(message: error.toString()));
        }
      }
    });
  }
}
