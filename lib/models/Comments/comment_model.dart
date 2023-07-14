import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? comment;
  Timestamp? createdAt;
  String? postId;
  String? userId;

  CommentModel({this.comment, this.createdAt, this.postId, this.userId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    createdAt = json['createdAt'];
    postId = json['postId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['postId'] = postId;
    data['userId'] = userId;
    return data;
  }
}
