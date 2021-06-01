// To parse this JSON data, do
//
//     final clientListResponse = clientListResponseFromJson(jsonString);

import 'dart:convert';

ClientListResponse clientListResponseFromJson(String str) => ClientListResponse.fromJson(json.decode(str));

String clientListResponseToJson(ClientListResponse data) => json.encode(data.toJson());

class ClientListResponse {
    ClientListResponse({
        this.data,
        this.status,
      //  this.message,
    });

    List<DataClient> data;
    bool status;
   // String message;

    factory ClientListResponse.fromJson(Map<String, dynamic> json) => ClientListResponse(
        data: json["data"] == null ? null : List<DataClient>.from(json["data"].map((x) => DataClient.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
      //  message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status == null ? null : status,
      //  "message": message == null ? null : message,
    };
}

class DataClient {
    DataClient({
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

    factory DataClient.fromJson(Map<String, dynamic> json) => DataClient(
        id: json["id"] == null ? null : json["id"],
        clientName: json["client_name"] == null ? null : json["client_name"],
        userName: json["user_name"] == null ? null : json["user_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "client_name": clientName == null ? null : clientName,
        "user_name": userName == null ? null : userName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
