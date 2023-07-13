import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  final RecipeModel post;
  const CommentsScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final commentsController = TextEditingController();

  @override
  void dispose() {
    commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: "Comments"),
      body: Column(
        children: [
          // AspectRatio(
          //   aspectRatio: 1,
          //   child: CachedNetworkImage(
          //     imageUrl: post.image.toString(),
          //     fit: BoxFit.contain,
          //   ),
          // ),
          Expanded(child: Container()),
          ListTile(
            title: const TextField(
              decoration: InputDecoration(
                hintText: "Add a comment...",
                border: InputBorder.none,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
