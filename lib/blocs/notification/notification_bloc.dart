import 'package:cookbook/models/Notification/notification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'notification_states_events.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationStateInit()) {
    on<NotificationEventFetch>(((event, emit) async {
      bool networkstatus = await isNetworkAvailable();
      if (networkstatus) {
        // notificaoin is loading......
        emit(NotificationStateFetching());
      } else {
        emit(NotificationStateError(error: "No internet connectoin"));
      }
      try {} catch (error) {}
    }));
  }
}
