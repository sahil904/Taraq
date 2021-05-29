// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.notification,
    this.data,
  });

  Notification notification;
  NotificationData data;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
        notification:
            json['notification'] == null ? null : Notification.fromJson(json['notification']),
        data: json['data'] == null ? null : NotificationData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        "notification": notification == null ? null : notification.toJson(),
        "data": data == null ? null : data.toJson(),
      };
}

class NotificationData {
  NotificationData({
    this.mediaUrl,
    this.body,
    this.type,
    this.objectId,
    this.title,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        mediaUrl: json['mediaUrl'],
        body: json['body'],
        type: json['purpose'],
        objectId: json['uid'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'mediaUrl': mediaUrl,
        'body': body,
        'purpose': type,
        'uid': objectId,
        'title': title,
      };
  String mediaUrl;
  String body;
  String type;
  String objectId;
  String title;
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
      };

  String title;
  String body;
}
