import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/secondary_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbarWidget(
        actions: [
          // settings button
          Container().box.make(),
        ],
      ),
      body: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          if (state is UserCollectionLoadedState) {
            return SafeArea(
              child: Column(
                children: [
                  Column(
                    children: [
                      SecondaryButtonWidget(
                        caption: AppText.signOutText,
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  ).box.make().p20(),
                ],
              ),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    SecondaryButtonWidget(
                      caption: AppText.signOutText,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                ).box.make().p20(),
              ],
            ),
          );
        },
      ),
    );
  }
}
