import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PageWidget extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? scrollController;
  const PageWidget({Key? key, required this.children, this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: children,
      ).box.make().p20(),
    );
  }
}
