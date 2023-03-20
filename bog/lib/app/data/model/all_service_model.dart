// To parse this JSON data, do
//
//     final allService = allServiceFromJson(jsonString);

import 'dart:convert';

class AllService {
  AllService({
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

  factory AllService.fromRawJson(String str) =>
      AllService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllService.fromJson(Map<String, dynamic> json) => AllService(
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
