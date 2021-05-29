// To parse this JSON data, do
//
//     final notificationListResponse = notificationListResponseFromJson(jsonString);

import 'dart:convert';

NotificationListResponse notificationListResponseFromJson(String str) => NotificationListResponse.fromJson(json.decode(str));

String notificationListResponseToJson(NotificationListResponse data) => json.encode(data.toJson());

class NotificationListResponse {
    NotificationListResponse({
        this.code,
        this.error,
        this.nums,
        this.totalData,
        this.msg,
        this.categoryList,
    });

    int code;
    bool error;
    String nums;
    String totalData;
    String msg;
    List<CategoryList> categoryList;

    factory NotificationListResponse.fromJson(Map<String, dynamic> json) => NotificationListResponse(
        code: json["code"] == null ? null : json["code"],
        error: json["error"] == null ? null : json["error"],
        nums: json["nums"] == null ? null : json["nums"],
        totalData: json["TotalData"] == null ? null : json["TotalData"],
        msg: json["msg"] == null ? null : json["msg"],
        categoryList: json["CategoryList"] == null ? null : List<CategoryList>.from(json["CategoryList"].map((x) => CategoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "error": error == null ? null : error,
        "nums": nums == null ? null : nums,
        "TotalData": totalData == null ? null : totalData,
        "msg": msg == null ? null : msg,
        "CategoryList": categoryList == null ? null : List<dynamic>.from(categoryList.map((x) => x.toJson())),
    };
}

class CategoryList {
    CategoryList({
        this.id,
        this.subject,
        this.message,
        this.purpose,
        this.bid,
        this.sendTime,
        this.status,
    });

    String id;
    String subject;
    String message;
    String purpose;
    String bid;
    String sendTime;
    String status;

    factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"] == null ? null : json["id"],
        subject: json["subject"] == null ? null : json["subject"],
        message: json["message"] == null ? null : json["message"],
        purpose: json["purpose"] == null ? null : json["purpose"],
        bid: json["bid"] == null ? null : json["bid"],
        sendTime: json["send_time"] == null ? null : json["send_time"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "subject": subject == null ? null : subject,
        "message": message == null ? null : message,
        "purpose": purpose == null ? null : purpose,
        "bid": bid == null ? null : bid,
        "send_time": sendTime == null ? null : sendTime,
        "status": status == null ? null : status,
    };
}
