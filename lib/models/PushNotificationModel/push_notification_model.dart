import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotificationModel {
  String? fcmToken;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  PushNotificationModel({
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  PushNotificationModel.fromJson(Map<String, dynamic> json) {
    fcmToken = json['fcmToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fcmToken'] = fcmToken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
