import 'package:cookbook/blocs/user-search/user_search_bloc.dart';
import 'package:cookbook/constants/app_config.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/models/User/user_model.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/circle_avatar/circle_avatar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:cookbook/widgets/text_fields/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

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
  final ScrollController _scrollController = ScrollController();
  int paginateBy = AppConfig.searchUserPagenateCount;

  @override
  void initState() {
    userSearchBloc = context.read<UserSearchBloc>();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          AppConfig.loadOnScrollHeight) {
        paginateBy += AppConfig.searchUserPagenateCount;
      }
    });
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
            child: TextFieldWidget(
              controller: TextEditingController(),
              onChanged: (value) {
                userSearchBloc.add(SearchTextChanged(value, paginateBy));
              },
              label: AppText.enterUserNameText,
              prefixIcon: Ionicons.search,
              textInputAction: TextInputAction.search,
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
                      var userData =
                          searchResults[index].data() as Map<String, dynamic>;
                      final userModel = UserModel.fromJson(userData);
                      return ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatarWidget(
                          photoUrl: userModel.photoUrl.toString(),
                        ),
                        title: userModel.fullName
                            .toString()
                            .text
                            .fontFamily(AppFonts.robotoMedium)
                            .xl
                            .make(),
                        subtitle: Text(userModel.email.toString()),
                        trailing: const Icon(Ionicons.chevron_forward),
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
