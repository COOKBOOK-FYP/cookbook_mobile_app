import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class UserEvent {}


// States
abstract class UserState {}

class UserStateInitial extends UserState {}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateInitial()) {}
}
