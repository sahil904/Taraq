// To parse this JSON data, do
//
//     final clientAddResponse = clientAddResponseFromJson(jsonString);

import 'dart:convert';

import 'package:test/model/client_list_response.dart';

import 'opertaion_list_response.dart';

OperationResponse clientAddResponseFromJson(String str) =>
    OperationResponse.fromJson(json.decode(str));

String clientAddResponseToJson(OperationResponse data) => json.encode(data.toJson());

class OperationResponse {
  OperationResponse({
    this.data,
    this.status,
    //  this.message,
  });

  DataOpertaion data;
  bool status;

  //int message;

  factory OperationResponse.fromJson(Map<String, dynamic> json) => OperationResponse(
        data: json["data"] == null ? null : DataOpertaion.fromJson(json["data"]),
        status: json["status"] == null ? null : json["status"],
        //  message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "status": status == null ? null : status,
        //   "message": message == null ? null : message,
      };
}
