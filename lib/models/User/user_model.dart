import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? photoUrl;
  String? userId;
  int? likes;
  int? postCount;
  String? bio;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? phoneNumber;
  String? address;
  int? followersCount;
  int? followingCount;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.photoUrl,
    this.userId,
    this.likes,
    this.postCount,
    this.bio,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
    this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    userId = json['userId'];
    likes = json['likes'];
    postCount = json['postCount'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['userId'] = userId;
    data['likes'] = likes;
    data['postCount'] = postCount;
    data['bio'] = bio;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['followersCount'] = followersCount;
    data['followingCount'] = followingCount;
    return data;
  }
}
