import 'package:cookbook/blocs/authentication/complete_profile/complete_profile_bloc.dart';
import 'package:cookbook/blocs/authentication/google/google_signin_bloc.dart';
import 'package:cookbook/blocs/authentication/signUp/signup_bloc.dart';
import 'package:cookbook/blocs/authentication/signin/signin_bloc.dart';
import 'package:cookbook/blocs/comments/comments_bloc.dart';
import 'package:cookbook/blocs/post/create_post/post_bloc.dart';
import 'package:cookbook/blocs/post/fetch_post/fetch_all_posts_bloc.dart';
import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
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
    BlocProvider<CompleteProfileBloc>(
      create: (context) => CompleteProfileBloc(),
    ),
    BlocProvider<PostBloc>(create: (context) => PostBloc()),
    BlocProvider<FetchPostBloc>(create: (context) => FetchPostBloc()),
    BlocProvider<FetchAllPostsBloc>(create: (context) => FetchAllPostsBloc()),
    BlocProvider<CommentsBloc>(create: (context) => CommentsBloc()),
  ];
}
