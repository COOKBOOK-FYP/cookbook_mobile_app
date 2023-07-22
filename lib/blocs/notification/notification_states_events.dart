part of 'notification_bloc.dart';

// Events
abstract class NotificationEvent {}

class NotificationEventFetch extends NotificationEvent {}

// States
abstract class NotificationState {}

class NotificationStateInit extends NotificationState {}

class NotificationStateFetching extends NotificationState {}

class NotificationStateFetched extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationStateFetched({required this.notifications});
}

class NotificationStateEmpty extends NotificationState {}

class NotificationStateError extends NotificationState {
  final String error;
  NotificationStateError({required this.error});
}
