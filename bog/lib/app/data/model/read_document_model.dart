// To parse this JSON data, do
//
//     final readDocumentModel = readDocumentModelFromJson(jsonString);

import 'dart:convert';

class ReadDocumentModel {
  ReadDocumentModel({
    this.id,
    this.userType,
    this.userId,
    this.name,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userType;
  String? userId;
  String? name;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory ReadDocumentModel.fromRawJson(String str) =>
      ReadDocumentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReadDocumentModel.fromJson(Map<String, dynamic> json) =>
      ReadDocumentModel(
        id: json["id"],
        userType: json["userType"],
        userId: json["userId"],
        name: json["name"],
        file: json["file"],
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
        "userType": userType,
        "userId": userId,
        "name": name,
        "file": file,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
