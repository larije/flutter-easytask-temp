// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  int recNo;
  String taskId;
  String taskName;
  String description;
  int taskValue;
  String remarks;
  int statusId;
  String developerId;
  String projId;

  Task({
    required this.recNo,
    required this.taskId,
    required this.taskName,
    required this.description,
    required this.taskValue,
    required this.remarks,
    required this.statusId,
    required this.developerId,
    required this.projId,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        recNo: json["recNo"],
        taskId: json["taskId"],
        taskName: json["taskName"],
        description: json["description"],
        taskValue: json["taskValue"],
        remarks: json["remarks"],
        statusId: json["statusId"],
        developerId: json["developerId"],
        projId: json["projId"],
      );

  Map<String, dynamic> toJson() => {
        "recNo": recNo,
        "taskId": taskId,
        "taskName": taskName,
        "description": description,
        "taskValue": taskValue,
        "remarks": remarks,
        "statusId": statusId,
        "developerId": developerId,
        "projId": projId,
      };
}
