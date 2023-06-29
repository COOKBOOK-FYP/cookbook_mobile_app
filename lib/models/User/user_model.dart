import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? photoUrl;
  String? userId;
  int? likes;
  int? postCount;
  String? bio;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? phoneNumber;
  String? location;
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
    this.location,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    userId = json['userId'];
    likes = json['likes'];
    postCount = json['postCount'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['fullName'] = fullName;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['userId'] = userId;
    data['likes'] = likes;
    data['postCount'] = postCount;
    data['bio'] = bio;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['phoneNumber'] = phoneNumber;
    data['location'] = location;
    data['followersCount'] = followersCount;
    data['followingCount'] = followingCount;
    return data;
  }
}
