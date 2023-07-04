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
  String? country;
  int? followersCount;
  int? followingCount;
  String? dateOfBirth;

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
    this.country,
    this.followersCount,
    this.followingCount,
    this.dateOfBirth,
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
    country = json['country'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    dateOfBirth = json['dateOfBirth'];
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
    data['country'] = country;
    data['followersCount'] = followersCount;
    data['followingCount'] = followingCount;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }
}
