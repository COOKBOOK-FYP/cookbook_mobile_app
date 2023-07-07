import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel {
  Timestamp? createdAt;
  Map? likes;
  String? description;
  String? category;
  Timestamp? updatedAt;
  String? image;
  List? ingredients;
  String? instructions;
  String? ownerId;
  String? postId;
  String? ownerName;
  String? ownerPhotoUrl;

  RecipeModel({
    this.createdAt,
    this.likes,
    this.description,
    this.category,
    this.updatedAt,
    this.image,
    this.ingredients,
    this.instructions,
    this.ownerId,
    this.postId,
    this.ownerName,
    this.ownerPhotoUrl,
  });

  RecipeModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    likes = json['likes'];
    description = json['description'];
    category = json['category'];
    updatedAt = json['updatedAt'];
    image = json['image'];
    ingredients = json['ingredients'];
    instructions = json['instructions'];
    ownerId = json['ownerId'];
    postId = json['postId'];
    ownerName = json['ownerName'];
    ownerPhotoUrl = json['ownerPhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['likes'] = likes;
    data['description'] = description;
    data['category'] = category;
    data['updatedAt'] = updatedAt;
    data['image'] = image;
    data['ingredients'] = ingredients;
    data['instructions'] = instructions;
    data['ownerId'] = ownerId;
    data['postId'] = postId;
    data['ownerName'] = ownerName;
    data['ownerPhotoUrl'] = ownerPhotoUrl;

    return data;
  }
}
