import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/screens/profile/widgets/profile_header_widget.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppbarWidget(),
      body: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          if (state is UserCollectionLoadedState) {
            return SafeArea(
              child: Column(
                children: [
                  Column(
                    children: [
                      const VxDivider(type: VxDividerType.horizontal),
                      ProfileHeaderWidget(
                        photoUrl: state.userDocument.photoUrl.toString(),
                        firstName: state.userDocument.firstName.toString(),
                        lastName: state.userDocument.lastName.toString(),
                        location: state.userDocument.location.toString(),
                        bio: state.userDocument.bio.toString(),
                      ),
                      const VxDivider(type: VxDividerType.horizontal),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.symmetric(horizontal: 10))
                      .make(),
                ],
              ),
            );
          }
          if (state is UserCollectionLoadingState) {
            return const LoadingWidget();
          }

          return SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
