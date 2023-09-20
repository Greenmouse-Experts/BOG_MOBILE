import 'dart:convert';

class GeneralInfoModel {
  String? id;
  String? userType;
  String? userId;
  String? organisationName;
  String? emailAddress;
  String? contactNumber;
  String? contactNumber2;
  String? regType;
  int? registrationNumber;
  String? businessAddress;
  String? role;
  String? operationalAddress;
  String? operationalEmail;
  String? yearsOfExperience;
  String? certificationOfPersonnel;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  GeneralInfoModel({
    this.id,
    this.userType,
    this.userId,
    this.organisationName,
    this.emailAddress,
    this.contactNumber,
    this.contactNumber2,
    this.regType,
    this.registrationNumber,
    this.businessAddress,
    this.role,
    this.operationalAddress,
    this.operationalEmail,
    this.yearsOfExperience,
    this.certificationOfPersonnel,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

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
        contactNumber2: json["contact_number_2"],
        regType: json["reg_type"],
        registrationNumber: json["registration_number"],
        businessAddress: json["business_address"],
        role: json["role"],
        operationalAddress: json["operational_address"],
        operationalEmail: json["operational_email_tel"],
        yearsOfExperience: json["years_of_experience"],
        certificationOfPersonnel: json["certification_of_personnel"],
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
        "contact_number_2": contactNumber2,
        "registration_number": registrationNumber,
        "business_address": businessAddress,
        "role": role,
        "operational_address": operationalAddress,
        "operational_email_tel": operationalEmail,
        "years_of_experience": yearsOfExperience,
        "certification_of_personnel": certificationOfPersonnel,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
