import 'package:cookbook/controllers/Auth/auth_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'complete_profile_states_and_events.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  CompleteProfileBloc() : super(CompleteProfileInitial()) {
    on<CompleteProfileEventSubmit>((event, emit) async {
      try {
        final connectionStatus = await isNetworkAvailable();
        if (connectionStatus == false) {
          emit(CompleteProfileFailed(error: "No internet connection"));
        } else {
          emit(CompleteProfileLoading());
          await AuthController.completeProfile(
            bio: event.bio,
            country: event.country,
            dateOfBirth: event.dateOfBirth,
            photoUrl: event.photoUrl,
          );
          emit(CompleteProfileSuccess());
        }
      } catch (error) {
        emit(CompleteProfileFailed(error: error.toString()));
      }
    });
  }
}
