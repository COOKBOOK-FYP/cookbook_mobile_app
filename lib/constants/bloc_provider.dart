import 'package:cookbook/blocs/Users/user_bloc.dart';
import 'package:cookbook/blocs/authentication/google/google_signin_bloc.dart';
import 'package:cookbook/blocs/authentication/signin/signin_bloc.dart';
import 'package:cookbook/blocs/session_handling/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider<SessionHandlingCubit>(
        create: (context) => SessionHandlingCubit()..initliazeRoute()),
    BlocProvider<GoogleSigninBloc>(create: (context) => GoogleSigninBloc()),
    BlocProvider<UserBloc>(create: (context) => UserBloc()),
    BlocProvider(create: (context) => SigninBloc())
  ];
}
