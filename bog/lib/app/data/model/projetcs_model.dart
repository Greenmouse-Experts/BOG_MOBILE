// To parse this JSON data, do
//
//     final myProjects = myProjectsFromJson(jsonString);

import 'dart:convert';

class MyProjects {
    MyProjects({
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
    dynamic serviceProviderId;
    int? totalCost;
    int? estimatedCost;
    int? duration;
    dynamic progress;
    dynamic servicePartnerProgress;
    dynamic endDate;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    ProjectData? projectData;

    factory MyProjects.fromRawJson(String str) => MyProjects.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MyProjects.fromJson(Map<String, dynamic> json) => MyProjects(
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
        endDate: json["endDate"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        projectData: json["projectData"] == null ? null : ProjectData.fromJson(json["projectData"]),
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
        "endDate": endDate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "projectData": projectData?.toJson(),
    };

    static List<MyProjects> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => MyProjects.fromJson(item)).toList();
  }
}

class ProjectData {
    ProjectData({
        this.id,
        this.userId,
        this.projectId,
        this.clientName,
        this.propertyName,
        this.projectLocation,
        this.propertyLga,
        this.projectType,
        this.buildingType,
        this.status,
        this.surveyPlan,
        this.structuralPlan,
        this.architecturalPlan,
        this.mechanicalPlan,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String? id;
    String? userId;
    String? projectId;
    String? clientName;
    dynamic propertyName;
    String? projectLocation;
    dynamic propertyLga;
    String? projectType;
    dynamic buildingType;
    String? status;
    String? surveyPlan;
    String? structuralPlan;
    String? architecturalPlan;
    dynamic mechanicalPlan;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory ProjectData.fromRawJson(String str) => ProjectData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
        id: json["id"],
        userId: json["userId"],
        projectId: json["projectId"],
        clientName: json["clientName"],
        propertyName: json["propertyName"],
        projectLocation: json["projectLocation"],
        propertyLga: json["propertyLga"],
        projectType: json["projectType"],
        buildingType: json["buildingType"],
        status: json["status"],
        surveyPlan: json["surveyPlan"],
        structuralPlan: json["structuralPlan"],
        architecturalPlan: json["architecturalPlan"],
        mechanicalPlan: json["mechanicalPlan"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "projectId": projectId,
        "clientName": clientName,
        "propertyName": propertyName,
        "projectLocation": projectLocation,
        "propertyLga": propertyLga,
        "projectType": projectType,
        "buildingType": buildingType,
        "status": status,
        "surveyPlan": surveyPlan,
        "structuralPlan": structuralPlan,
        "architecturalPlan": architecturalPlan,
        "mechanicalPlan": mechanicalPlan,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
