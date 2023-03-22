// To parse this JSON data, do
//
//     final workExperienceModel = workExperienceModelFromJson(jsonString);

import 'dart:convert';

class WorkExperienceModel {
  WorkExperienceModel({
    this.id,
    this.userType,
    this.userId,
    this.name,
    this.value,
    this.date,
    this.fileUrl,
    this.yearsOfExperience,
    this.companyInvolvement,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userType;
  String? userId;
  String? name;
  String? value;
  DateTime? date;
  String? fileUrl;
  String? yearsOfExperience;
  String? companyInvolvement;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory WorkExperienceModel.fromRawJson(String str) =>
      WorkExperienceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) =>
      WorkExperienceModel(
        id: json["id"],
        userType: json["userType"],
        userId: json["userId"],
        name: json["name"],
        value: json["value"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fileUrl: json["fileUrl"],
        yearsOfExperience: json["years_of_experience"],
        companyInvolvement: json["company_involvement"],
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
        "value": value,
        "date": date?.toIso8601String(),
        "fileUrl": fileUrl,
        "years_of_experience": yearsOfExperience,
        "company_involvement": companyInvolvement,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
