// To parse this JSON data, do
//
//     final projectListResponse = projectListResponseFromJson(jsonString);

import 'dart:convert';

ProjectListResponse projectListResponseFromJson(String str) => ProjectListResponse.fromJson(json.decode(str));

String projectListResponseToJson(ProjectListResponse data) => json.encode(data.toJson());

class ProjectListResponse {
    ProjectListResponse({
        this.data,
        this.status,
      //  this.message,
    });

    List<DataProject> data;
    bool status;
   // int message;

    factory ProjectListResponse.fromJson(Map<String, dynamic> json) => ProjectListResponse(
        data: json["data"] == null ? null : List<DataProject>.from(json["data"].map((x) => DataProject.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
       // message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status == null ? null : status,
      //  "message": message == null ? null : message,
    };
}

class DataProject {
    DataProject({
        this.id,
        this.projectName,
        this.image,
        this.userName,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String projectName;
    String image;
    String userName;
    DateTime createdAt;
    DateTime updatedAt;

    factory DataProject.fromJson(Map<String, dynamic> json) => DataProject(
        id: json["id"] == null ? null : json["id"],
        projectName: json["project_name"] == null ? null : json["project_name"],
        image: json["image"] == null ? null : json["image"],
        userName: json["user_name"] == null ? null : json["user_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "project_name": projectName == null ? null : projectName,
        "image": image == null ? null : image,
        "user_name": userName == null ? null : userName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
