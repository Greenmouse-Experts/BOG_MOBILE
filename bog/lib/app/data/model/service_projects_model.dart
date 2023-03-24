// To parse this JSON data, do
//
//     final serviceProjectsModel = serviceProjectsModelFromJson(jsonString);

import 'dart:convert';

class ServiceProjectsModel {
  ServiceProjectsModel({
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
    this.projectData,
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
  dynamic projectData;

  factory ServiceProjectsModel.fromRawJson(String str) =>
      ServiceProjectsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceProjectsModel.fromJson(Map<String, dynamic> json) =>
      ServiceProjectsModel(
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
        projectData: json["projectData"],
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
        "projectData": projectData,
      };
}
