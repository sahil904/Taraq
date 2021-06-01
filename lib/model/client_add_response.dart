// To parse this JSON data, do
//
//     final clientAddResponse = clientAddResponseFromJson(jsonString);

import 'dart:convert';

import 'package:test/model/client_list_response.dart';

ClientAddResponse clientAddResponseFromJson(String str) => ClientAddResponse.fromJson(json.decode(str));

String clientAddResponseToJson(ClientAddResponse data) => json.encode(data.toJson());

class ClientAddResponse {
    ClientAddResponse({
        this.data,
        this.status,
      //  this.message,
    });

    DataClient data;
    bool status;
    //int message;

    factory ClientAddResponse.fromJson(Map<String, dynamic> json) => ClientAddResponse(
        data: json["data"] == null ? null : DataClient.fromJson(json["data"]),
        status: json["status"] == null ? null : json["status"],
      //  message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "status": status == null ? null : status,
     //   "message": message == null ? null : message,
    };
}

