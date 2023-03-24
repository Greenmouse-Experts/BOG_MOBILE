// To parse this JSON data, do
//
//     final availableProjectsModel = availableProjectsModelFromJson(jsonString);

import 'dart:convert';

class AvailableProjectsModel {
  AvailableProjectsModel({
    this.id,
    this.userId,
    this.projectId,
    this.estimatedCost,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.project,
    this.hasBid,
    this.bid,
    this.projectDetails,
  });

  String? id;
  String? userId;
  String? projectId;
  int? estimatedCost;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Project? project;
  bool? hasBid;
  Bid? bid;
  List<ProjectDetail>? projectDetails;

  factory AvailableProjectsModel.fromRawJson(String str) =>
      AvailableProjectsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AvailableProjectsModel.fromJson(Map<String, dynamic> json) =>
      AvailableProjectsModel(
        id: json["id"],
        userId: json["userId"],
        projectId: json["projectId"],
        estimatedCost: json["estimatedCost"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        hasBid: json["hasBid"],
        bid: json["bid"] == null ? null : Bid.fromJson(json["bid"]),
        projectDetails: json["projectDetails"] == null
            ? []
            : List<ProjectDetail>.from(
                json["projectDetails"]!.map((x) => ProjectDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "projectId": projectId,
        "estimatedCost": estimatedCost,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "project": project?.toJson(),
        "hasBid": hasBid,
        "bid": bid?.toJson(),
        "projectDetails": projectDetails == null
            ? []
            : List<dynamic>.from(projectDetails!.map((x) => x.toJson())),
      };
}

class Bid {
  Bid({
    this.id,
    this.userId,
    this.projectId,
    this.projectCost,
    this.status,
    this.deliveryTimeLine,
    this.areYouInterested,
    this.reasonOfInterest,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userId;
  String? projectId;
  int? projectCost;
  String? status;
  int? deliveryTimeLine;
  bool? areYouInterested;
  String? reasonOfInterest;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Bid.fromRawJson(String str) => Bid.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        id: json["id"],
        userId: json["userId"],
        projectId: json["projectId"],
        projectCost: json["projectCost"],
        status: json["status"],
        deliveryTimeLine: json["deliveryTimeLine"],
        areYouInterested: json["areYouInterested"],
        reasonOfInterest: json["reasonOfInterest"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "projectId": projectId,
        "projectCost": projectCost,
        "status": status,
        "deliveryTimeLine": deliveryTimeLine,
        "areYouInterested": areYouInterested,
        "reasonOfInterest": reasonOfInterest,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Project {
  Project({
    this.id,
    this.userId,
    this.title,
    this.projectSlug,
    this.description,
    this.projectTypes,
    this.status,
    this.approvalStatus,
    this.serviceProviderId,
    this.totalCost,
    this.estimatedCost,
    this.duration,
    this.progress,
    this.servicePartnerProgress,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userId;
  String? title;
  String? projectSlug;
  dynamic description;
  String? projectTypes;
  String? status;
  String? approvalStatus;
  String? serviceProviderId;
  int? totalCost;
  int? estimatedCost;
  int? duration;
  int? progress;
  int? servicePartnerProgress;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        projectSlug: json["projectSlug"],
        description: json["description"],
        projectTypes: json["projectTypes"],
        status: json["status"],
        approvalStatus: json["approvalStatus"],
        serviceProviderId: json["serviceProviderId"],
        totalCost: json["totalCost"],
        estimatedCost: json["estimatedCost"],
        duration: json["duration"],
        progress: json["progress"],
        servicePartnerProgress: json["service_partner_progress"],
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "projectSlug": projectSlug,
        "description": description,
        "projectTypes": projectTypes,
        "status": status,
        "approvalStatus": approvalStatus,
        "serviceProviderId": serviceProviderId,
        "totalCost": totalCost,
        "estimatedCost": estimatedCost,
        "duration": duration,
        "progress": progress,
        "service_partner_progress": servicePartnerProgress,
        "endDate": endDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class ProjectDetail {
  ProjectDetail({
    this.id,
    this.userId,
    this.projectId,
    this.serviceFormId,
    this.value,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? userId;
  String? projectId;
  String? serviceFormId;
  String? value;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProjectDetail.fromRawJson(String str) =>
      ProjectDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectDetail.fromJson(Map<String, dynamic> json) => ProjectDetail(
        id: json["id"],
        userId: json["userID"],
        projectId: json["projectID"],
        serviceFormId: json["serviceFormID"],
        value: json["value"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "projectID": projectId,
        "serviceFormID": serviceFormId,
        "value": value,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
