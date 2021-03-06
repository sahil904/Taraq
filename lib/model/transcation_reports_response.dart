// To parse this JSON data, do
//
//     final transcationResponse = transcationResponseFromJson(jsonString);

import 'dart:convert';

TranscationReportResponse transcationResponseFromJson(String str) => TranscationReportResponse.fromJson(json.decode(str));

String transcationResponseToJson(TranscationReportResponse data) => json.encode(data.toJson());

class TranscationReportResponse {
    TranscationReportResponse({
        this.status,
        this.message,
        this.data,

    });

    bool status;
    int message;
    List<Data> data;

    factory TranscationReportResponse.fromJson(Map<String, dynamic> json) => TranscationReportResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),

    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        this.id,
        this.projectName,
        this.clientName,
        this.operationName,
        this.price,
        this.notes,
        this.date,
        this.userName,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String projectName;
    String clientName;
    String operationName;
    String price;
    String notes;
    DateTime date;
    String userName;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        projectName: json["project_name"] == null ? null : json["project_name"],
        clientName: json["client_name"] == null ? null : json["client_name"],
        operationName: json["operation_name"] == null ? null : json["operation_name"],
        price: json["price"] == null ? null : json["price"],
        notes: json["notes"] == null ? null : json["notes"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        userName: json["user_name"] == null ? null : json["user_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "project_name": projectName == null ? null : projectName,
        "client_name": clientName == null ? null : clientName,
        "operation_name": operationName == null ? null : operationName,
        "price": price == null ? null : price,
        "notes": notes == null ? null : notes,
        "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "user_name": userName == null ? null : userName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
