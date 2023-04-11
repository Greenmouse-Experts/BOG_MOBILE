// To parse this JSON data, do
//
//     final projectAnalysisModel = projectAnalysisModelFromJson(jsonString);

import 'dart:convert';

class ProjectAnalysisModel {
    ProjectAnalysisModel({
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
        this.totalEndDate,
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
    dynamic totalEndDate;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory ProjectAnalysisModel.fromRawJson(String str) => ProjectAnalysisModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProjectAnalysisModel.fromJson(Map<String, dynamic> json) => ProjectAnalysisModel(
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
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        totalEndDate: json["totalEndDate"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "totalEndDate": totalEndDate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
