// To parse this JSON data, do
//
//     final orgInfoModel = orgInfoModelFromJson(jsonString);

import 'dart:convert';

class OrgInfoModel {
  OrgInfoModel({
    this.id,
    this.userType,
    this.userId,
    this.organisationType,
    this.others,
    this.incorporationDate,
    this.directorFullname,
    this.directorDesignation,
    this.directorPhone,
    this.directorEmail,
    this.contactPhone,
    this.contactEmail,
    this.othersOperations,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userType;
  String? userId;
  String? organisationType;
  String? others;
  DateTime? incorporationDate;
  String? directorFullname;
  String? directorDesignation;
  int? directorPhone;
  String? directorEmail;
  int? contactPhone;
  String? contactEmail;
  String? othersOperations;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory OrgInfoModel.fromRawJson(String str) =>
      OrgInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrgInfoModel.fromJson(Map<String, dynamic> json) => OrgInfoModel(
        id: json["id"],
        userType: json["userType"],
        userId: json["userId"],
        organisationType: json["organisation_type"],
        others: json["others"],
        incorporationDate: json["Incorporation_date"] == null
            ? null
            : DateTime.parse(json["Incorporation_date"]),
        directorFullname: json["director_fullname"],
        directorDesignation: json["director_designation"],
        directorPhone: json["director_phone"],
        directorEmail: json["director_email"],
        contactPhone: json["contact_phone"],
        contactEmail: json["contact_email"],
        othersOperations: json["others_operations"],
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
        "organisation_type": organisationType,
        "others": others,
        "Incorporation_date": incorporationDate?.toIso8601String(),
        "director_fullname": directorFullname,
        "director_designation": directorDesignation,
        "director_phone": directorPhone,
        "director_email": directorEmail,
        "contact_phone": contactPhone,
        "contact_email": contactEmail,
        "others_operations": othersOperations,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
