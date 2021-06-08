// To parse this JSON data, do
//
//     final dashboardResponse = dashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) => DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) => json.encode(data.toJson());

class DashboardResponse {
    DashboardResponse({
        this.projects,
        this.clients,
        this.operations,
        this.transactions,
    });

    List<Project> projects;
    List<Client> clients;
    List<Operation> operations;
    List<Transaction> transactions;

    factory DashboardResponse.fromJson(Map<String, dynamic> json) => DashboardResponse(
        projects: json["projects"] == null ? null : List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
        clients: json["clients"] == null ? null : List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
        operations: json["operations"] == null ? null : List<Operation>.from(json["operations"].map((x) => Operation.fromJson(x))),
        transactions: json["transactions"] == null ? null : List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "projects": projects == null ? null : List<dynamic>.from(projects.map((x) => x.toJson())),
        "clients": clients == null ? null : List<dynamic>.from(clients.map((x) => x.toJson())),
        "operations": operations == null ? null : List<dynamic>.from(operations.map((x) => x.toJson())),
        "transactions": transactions == null ? null : List<dynamic>.from(transactions.map((x) => x.toJson())),
    };
}

class Client {
    Client({
        this.id,
        this.clientName,
        this.count,
    });

    int id;
    String clientName;
    int count;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"] == null ? null : json["id"],
        clientName: json["client_name"] == null ? null : json["client_name"],
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "client_name": clientName == null ? null : clientName,
        "count": count == null ? null : count,
    };
}

class Operation {
    Operation({
        this.id,
        this.operationName,
        this.count,
        this.price,
    });

    int id;
    String operationName;
    int count;
    String price;

    factory Operation.fromJson(Map<String, dynamic> json) => Operation(
        id: json["id"] == null ? null : json["id"],
        operationName: json["operation_name"] == null ? null : json["operation_name"],
        count: json["count"] == null ? null : json["count"],
        price: json["price"] == null ? null : json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "operation_name": operationName == null ? null : operationName,
        "count": count == null ? null : count,
        "price": price == null ? null : price,
    };
}

class Project {
    Project({
        this.id,
        this.projectName,
        this.count,
    });

    int id;
    String projectName;
    int count;

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"] == null ? null : json["id"],
        projectName: json["project_name"] == null ? null : json["project_name"],
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "project_name": projectName == null ? null : projectName,
        "count": count == null ? null : count,
    };
}

class Transaction {
    Transaction({
        this.id,
        this.projectName,
        this.clientName,
        this.operationName,
        this.price,
        this.notes,
    });

    int id;
    String projectName;
    String clientName;
    String operationName;
    String price;
    String notes;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"] == null ? null : json["id"],
        projectName: json["project_name"] == null ? null : json["project_name"],
        clientName: json["client_name"] == null ? null : json["client_name"],
        operationName: json["operation_name"] == null ? null : json["operation_name"],
        price: json["price"] == null ? null : json["price"],
        notes: json["notes"] == null ? null : json["notes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "project_name": projectName == null ? null : projectName,
        "client_name": clientName == null ? null : clientName,
        "operation_name": operationName == null ? null : operationName,
        "price": price == null ? null : price,
        "notes": notes == null ? null : notes,
    };
}
