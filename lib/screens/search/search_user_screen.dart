import 'package:cookbook/blocs/user-search/user_search_bloc.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/models/User/user_model.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/circle_avatar/circle_avatar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchUserScreenState();
  }
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  String searchText = '';
  late UserSearchBloc userSearchBloc;

  @override
  void initState() {
    userSearchBloc = context.read<UserSearchBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.searchUserText),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                userSearchBloc.add(SearchTextChanged(value));
              },
              decoration: const InputDecoration(
                hintText: 'Enter user name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserSearchBloc, UserSearchState>(
              builder: (context, state) {
                if (state is UserSearchLoading) {
                  return const LoadingWidget();
                } else if (state is UserSearchLoaded) {
                  final searchResults = state.searchResults;

                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final userData =
                          searchResults[index].data() as Map<String, dynamic>;
                      final userModel = UserModel.fromJson(userData);
                      return ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatarWidget(
                          photoUrl: userModel.photoUrl.toString(),
                        ),
                        title: Text(userModel.fullName.toString()),
                        subtitle: Text(userModel.email.toString()),
                        onTap: () {
                          // pass user model to the next screen
                        },
                        // Add other user details as needed
                      );
                    },
                  );
                } else if (state is UserSearchError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
