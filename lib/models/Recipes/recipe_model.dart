import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel {
  Timestamp? createdAt;
  String? description;
  String? category;
  Timestamp? updatedAt;
  String? image;
  List? ingredients;
  String? instructions;
  String? userId;

  RecipeModel(
      {this.createdAt,
      this.description,
      this.category,
      this.updatedAt,
      this.image,
      this.ingredients,
      this.instructions,
      this.userId});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    description = json['description'];
    category = json['category'];
    updatedAt = json['updatedAt'];
    image = json['image'];
    ingredients = json['ingredients'];
    instructions = json['instructions'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['category'] = category;
    data['updatedAt'] = updatedAt;
    data['image'] = image;
    data['ingredients'] = ingredients;
    data['instructions'] = instructions;
    data['userId'] = userId;
    return data;
  }
}
