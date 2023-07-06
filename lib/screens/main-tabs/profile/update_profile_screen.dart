import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SecondaryAppbarWidget(title: "Update Profile"),
    );
  }
}
