import 'package:cookbook/blocs/post/fetch_post_by_id/fetch_post_by_id_bloc.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:cookbook/widgets/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final String postId;
  const RecipeDetailsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final fetchPostByIdBloc = FetchPostByIdBloc();
  @override
  void initState() {
    fetchPostByIdBloc.add(FetchPostByIdGetDataEvent(widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: "Recipe Details"),
      body: BlocBuilder<FetchPostByIdBloc, FetchPostByIdState>(
        bloc: fetchPostByIdBloc,
        builder: (context, state) {
          if (state is FetchPostByIdLoadedState) {
            return PageWidget(
              children: [
                PostWidget(post: state.recipeModel),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
