import 'package:cookbook/constants/app_images.dart';

class OnboardingModel {
  final String title;
  final String image;

  OnboardingModel({
    required this.title,
    required this.image,
  });
}

List<OnboardingModel> contents = [
  OnboardingModel(
    title: "Find recipes suitable for you or invent new one for others.",
    image: ImageAssets.onboarding1,
  ),
  OnboardingModel(
    title: "Customize your food search according to your own special need.",
    image: ImageAssets.onboarding2,
  ),
  OnboardingModel(
    title: "Let's explore the recipe world",
    image: ImageAssets.onboarding3,
  ),
];
