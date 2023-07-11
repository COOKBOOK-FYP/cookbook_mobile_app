import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfileRecipeImageWidget extends StatelessWidget {
  final RecipeModel recipe;

  const ProfileRecipeImageWidget({Key? key, required this.recipe})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('tapped'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(
          imageUrl: recipe.image.toString(),
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              const Icon(Ionicons.image_outline),
        ),
      ),
    );
  }
}
