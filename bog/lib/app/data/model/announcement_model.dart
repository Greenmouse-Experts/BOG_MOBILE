// To parse this JSON data, do
//
//     final announcementModel = announcementModelFromJson(jsonString);

import 'dart:convert';

class AnnouncementModel {
  AnnouncementModel({
    this.id,
    this.title,
    this.content,
    this.user,
    this.expiredAt,
    this.supportingDocument,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? title;
  String? content;
  String? user;
  DateTime? expiredAt;
  String? supportingDocument;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory AnnouncementModel.fromRawJson(String str) =>
      AnnouncementModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        user: json["user"],
        expiredAt: json["expiredAt"] == null
            ? null
            : DateTime.parse(json["expiredAt"]),
        supportingDocument: json["supportingDocument"],
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
        "title": title,
        "content": content,
        "user": user,
        "expiredAt": expiredAt?.toIso8601String(),
        "supportingDocument": supportingDocument,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
