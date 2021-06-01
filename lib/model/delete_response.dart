// To parse this JSON data, do
//
//     final deletedResponse = deletedResponseFromJson(jsonString);

import 'dart:convert';

DeletedResponse deletedResponseFromJson(String str) => DeletedResponse.fromJson(json.decode(str));

String deletedResponseToJson(DeletedResponse data) => json.encode(data.toJson());

class DeletedResponse {
  DeletedResponse({
    this.data,
    this.status,
    this.message,
  });

  dynamic data;
  bool status;
  String message;

  factory DeletedResponse.fromJson(Map<String, dynamic> json) => DeletedResponse(
    data: json["data"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
