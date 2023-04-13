// To parse this JSON data, do
//
//     final adminProgressModel = adminProgressModelFromJson(jsonString);

import 'dart:convert';

class AdminProgressModel {
  AdminProgressModel({
    this.id,
    this.projectId,
    this.body,
    this.image,
    this.serviceProviderId,
    this.by,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? projectId;
  String? body;
  String? image;
  dynamic serviceProviderId;
  String? by;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AdminProgressModel.fromRawJson(String str) =>
      AdminProgressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminProgressModel.fromJson(Map<String, dynamic> json) =>
      AdminProgressModel(
        id: json["id"],
        projectId: json["projectId"],
        body: json["body"],
        image: json["image"],
        serviceProviderId: json["serviceProviderID"],
        by: json["by"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectId": projectId,
        "body": body,
        "image": image,
        "serviceProviderID": serviceProviderId,
        "by": by,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
