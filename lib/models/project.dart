// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'dart:convert';

List<Project> projectFromJson(String str) =>
    List<Project>.from(json.decode(str).map((x) => Project.fromJson(x)));

String projectToJson(List<Project> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Project {
  int recNo;
  String projId;
  String projTitle;
  String description;
  int statusId;
  String projOwner;
  String projLeader;
  String remarks;
  String transDate;
  String? userId;

  Project({
    required this.recNo,
    required this.projId,
    required this.projTitle,
    required this.description,
    required this.statusId,
    required this.projOwner,
    required this.projLeader,
    required this.remarks,
    required this.transDate,
    this.userId,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        recNo: json["recNo"],
        projId: json["projId"],
        projTitle: json["projTitle"],
        description: json["description"],
        statusId: json["statusId"],
        projOwner: json["projOwner"],
        projLeader: json["projLeader"],
        remarks: json["remarks"],
        transDate: json["transDate"],
        userId: json["userId"] == null ? null : "",
      );

  Map<String, dynamic> toJson() => {
        "recNo": recNo,
        "projId": projId,
        "projTitle": projTitle,
        "description": description,
        "statusId": statusId,
        "projOwner": projOwner,
        "projLeader": projLeader,
        "remarks": remarks,
        "transDate": transDate,
        "userId": userId,
      };
}
