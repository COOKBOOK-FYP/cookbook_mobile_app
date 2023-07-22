import 'package:cookbook/controllers/Notification/notification_controller.dart';
import 'package:cookbook/models/Notification/notification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'notification_states_events.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationStateInit()) {
    on<NotificationEventFetch>(((event, emit) async {
      bool networkstatus = await isNetworkAvailable();
      if (networkstatus) {
        emit(NotificationStateFetching());
        try {
          final notifications =
              await NotificationController.getNotificationsForCurrentUser();
          if (notifications.isEmpty) {
            emit(NotificationStateEmpty());
          } else {
            emit(NotificationStateFetched(notifications: notifications));
          }
        } catch (error) {
          emit(NotificationStateError(error: error.toString()));
        }
      } else {
        emit(NotificationStateError(error: "No internet connectoin"));
      }
    }));
  }
}
