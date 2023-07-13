part of 'splash_cubit.dart';

@immutable
abstract class SessionHandlingState {}

class SessionHandlingInitial extends SessionHandlingState {}

class SessionHandlingHomeScreen extends SessionHandlingState {
  final User? user;
  SessionHandlingHomeScreen({this.user});
}

class SessionHandlingLoginScreen extends SessionHandlingState {}

class SessionHandlingFailed extends SessionHandlingState {}

class SessionHandlingNoInternet extends SessionHandlingState {}

class SessionHandlingOnBoarding extends SessionHandlingState {}
