// To parse this JSON data, do
//
//     final clientListResponse = clientListResponseFromJson(jsonString);

import 'dart:convert';

OperationListResponse clientListResponseFromJson(String str) => OperationListResponse.fromJson(json.decode(str));

String clientListResponseToJson(OperationListResponse data) => json.encode(data.toJson());

class OperationListResponse {
    OperationListResponse({
        this.data,
        this.status,
      //  this.message,
    });

    List<DataOpertaion> data;
    bool status;
   // String message;

    factory OperationListResponse.fromJson(Map<String, dynamic> json) => OperationListResponse(
        data: json["data"] == null ? null : List<DataOpertaion>.from(json["data"].map((x) => DataOpertaion.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
      //  message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status == null ? null : status,
      //  "message": message == null ? null : message,
    };
}

class DataOpertaion {
    DataOpertaion({
        this.id,
        this.clientName,
        this.userName,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String clientName;
    String userName;
    DateTime createdAt;
    DateTime updatedAt;

    factory DataOpertaion.fromJson(Map<String, dynamic> json) => DataOpertaion(
        id: json["id"] == null ? null : json["id"],
        clientName: json["operation_name"] == null ? null : json["operation_name"],
        userName: json["user_name"] == null ? null : json["user_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "operation_name": clientName == null ? null : clientName,
        "user_name": userName == null ? null : userName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
