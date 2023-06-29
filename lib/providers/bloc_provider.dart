import 'package:cookbook/blocs/authentication/google/google_signin_bloc.dart';
import 'package:cookbook/blocs/authentication/signUp/signup_bloc.dart';
import 'package:cookbook/blocs/authentication/signin/signin_bloc.dart';
import 'package:cookbook/blocs/session_handling/splash_cubit.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/blocs/user-search/user_search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider<SessionHandlingCubit>(
        create: (context) => SessionHandlingCubit()..initliazeRoute()),
    BlocProvider<GoogleSigninBloc>(create: (context) => GoogleSigninBloc()),
    BlocProvider<SigninBloc>(create: (context) => SigninBloc()),
    BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
    BlocProvider<UserCollectionBloc>(create: (context) => UserCollectionBloc()),
    BlocProvider<UserSearchBloc>(create: (context) => UserSearchBloc()),
  ];
}
