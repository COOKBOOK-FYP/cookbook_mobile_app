import 'package:cookbook/blocs/Users/user_bloc.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppbarWidget(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserStateSuccess) {
            print(state.user.photoURL);
          }
          return PageWidget(
            children: [],
          );
        },
      ),
    );
  }
}
