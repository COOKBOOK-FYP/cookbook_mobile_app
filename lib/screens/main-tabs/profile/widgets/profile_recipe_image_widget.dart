import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfileRecipeImageWidget extends StatefulWidget {
  final RecipeModel recipe;

  const ProfileRecipeImageWidget({Key? key, required this.recipe})
      : super(key: key);

  @override
  State<ProfileRecipeImageWidget> createState() =>
      _ProfileRecipeImageWidgetState();
}

class _ProfileRecipeImageWidgetState extends State<ProfileRecipeImageWidget> {
  countPostLikes(Map? likes) async {
    int count = 0;
    if (likes == null) {
      return count;
    }
    for (var val in likes.values) {
      if (val == true) {
        count += 1;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('tapped'),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: widget.recipe.image.toString(),
            fit: BoxFit.cover,
            placeholder: (context, url) => const LoadingWidget(),
            errorWidget: (context, url, error) =>
                const Icon(Ionicons.image_outline),
          ),
          // "likes: ${countPostLikes(widget.recipe.likes)}".text.make(),
        ],
      ),
    );
  }
}
