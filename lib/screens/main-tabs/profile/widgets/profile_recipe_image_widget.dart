import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';

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
        child: Image.network(
          recipe.image.toString(),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null
                  ? child
                  : const SizedBox(
                      child: LoadingWidget(),
                    ),
        ),
      ),
    );
  }
}
