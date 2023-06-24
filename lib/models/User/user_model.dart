import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? displayName;
  String? email;
  String? photoURL;
  String? uid;
  String? likes;
  String? postCount;
  String? bio;
  String? username;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? phoneNumber;
  String? address;

  UserModel({
    this.displayName,
    this.email,
    this.photoURL,
    this.uid,
    this.likes,
    this.postCount,
    this.bio,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
    this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoURL'];
    uid = json['uid'];
    likes = json['likes'];
    postCount = json['postCount'];
    bio = json['bio'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoURL'] = photoURL;
    data['uid'] = uid;
    data['likes'] = likes;
    data['postCount'] = postCount;
    data['bio'] = bio;
    data['username'] = username;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    return data;
  }
}
