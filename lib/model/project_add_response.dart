// To parse this JSON data, do
//
//     final projectAddResponse = projectAddResponseFromJson(jsonString);

import 'dart:convert';

import 'package:test/model/project_list_response.dart';

ProjectAddResponse projectAddResponseFromJson(String str) => ProjectAddResponse.fromJson(json.decode(str));

String projectAddResponseToJson(ProjectAddResponse data) => json.encode(data.toJson());

class ProjectAddResponse {
    ProjectAddResponse({
        this.data,
        this.status,
        this.message,
    });

    DataProject data;
    bool status;
    int message;

    factory ProjectAddResponse.fromJson(Map<String, dynamic> json) => ProjectAddResponse(
        data: json["data"] == null ? null : DataProject.fromJson(json["data"]),
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "status": status == null ? null : status,
        "message": message == null ? null : message,
    };
}

