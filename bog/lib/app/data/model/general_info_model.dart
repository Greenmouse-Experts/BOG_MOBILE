// To parse this JSON data, do
//
//     final generalInfoModel = generalInfoModelFromJson(jsonString);

import 'dart:convert';

class GeneralInfoModel {
  GeneralInfoModel({
    this.id,
    this.userType,
    this.userId,
    this.organisationName,
    this.emailAddress,
    this.contactNumber,
    this.regType,
    this.registrationNumber,
    this.businessAddress,
    this.operationalAddress,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userType;
  String? userId;
  String? organisationName;
  String? emailAddress;
  int? contactNumber;
  String? regType;
  int? registrationNumber;
  String? businessAddress;
  String? operationalAddress;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory GeneralInfoModel.fromRawJson(String str) =>
      GeneralInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeneralInfoModel.fromJson(Map<String, dynamic> json) =>
      GeneralInfoModel(
        id: json["id"],
        userType: json["userType"],
        userId: json["userId"],
        organisationName: json["organisation_name"],
        emailAddress: json["email_address"],
        contactNumber: json["contact_number"],
        regType: json["reg_type"],
        registrationNumber: json["registration_number"],
        businessAddress: json["business_address"],
        operationalAddress: json["operational_address"],
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
        "organisation_name": organisationName,
        "email_address": emailAddress,
        "contact_number": contactNumber,
        "reg_type": regType,
        "registration_number": registrationNumber,
        "business_address": businessAddress,
        "operational_address": operationalAddress,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
