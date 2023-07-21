import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? type;
  String? fullName;
  String? userId;
  String? userPhotoUrl;
  String? postId;
  String? mediaUrl;
  Timestamp? createdAt;
  String? commentData;

  NotificationModel({
    this.type,
    this.fullName,
    this.userId,
    this.userPhotoUrl,
    this.postId,
    this.mediaUrl,
    this.createdAt,
    this.commentData,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    fullName = json['fullName'];
    userId = json['userId'];
    userPhotoUrl = json['userPhotoUrl'];
    postId = json['postId'];
    mediaUrl = json['mediaUrl'];
    createdAt = json['createdAt'];
    commentData = json['commentData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['fullName'] = fullName;
    data['userId'] = userId;
    data['userPhotoUrl'] = userPhotoUrl;
    data['postId'] = postId;
    data['mediaUrl'] = mediaUrl;
    data['createdAt'] = createdAt;
    data['commentData'] = commentData;
    return data;
  }
}
