// To parse this JSON data, do
//
//     final serviceTypeModel = serviceTypeModelFromJson(jsonString);

import 'dart:convert';

class ServiceTypeModel {
  ServiceTypeModel({
    this.id,
    this.title,
    this.serviceId,
    this.description,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.service,
  });

  String? id;
  String? title;
  String? serviceId;
  String? description;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Service? service;

  factory ServiceTypeModel.fromRawJson(String str) =>
      ServiceTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) =>
      ServiceTypeModel(
        id: json["id"],
        title: json["title"],
        serviceId: json["serviceId"],
        description: json["description"],
        slug: json["slug"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "serviceId": serviceId,
        "description": description,
        "slug": slug,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "service": service?.toJson(),
      };
}

class Service {
  Service({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? name;
  String? slug;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
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
        "name": name,
        "slug": slug,
        "icon": icon,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
