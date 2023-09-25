// To parse this JSON data, do
//
//     final genKyc = genKycFromJson(jsonString);

import 'dart:convert';

class GenKyc {
  GenKyc({
    this.isKycCompleted,
    this.suppyCategory,
    this.kycFinancialData,
    this.kycGeneralInfo,
    this.kycOrganisationInfo,
    this.kycTaxPermits,
    this.kycWorkExperience,
    this.kycDocuments,
  });

  bool? isKycCompleted;
  SuppyCategory? suppyCategory;
  KycFinancialData? kycFinancialData;
  KycGeneralInfo? kycGeneralInfo;
  KycOrganisationInfo? kycOrganisationInfo;
  KycTaxPermits? kycTaxPermits;
  List<Map<String, String?>>? kycWorkExperience;
  List<SuppyCategory>? kycDocuments;

  factory GenKyc.fromRawJson(String str) => GenKyc.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenKyc.fromJson(Map<String, dynamic> json) => GenKyc(
        isKycCompleted: json["isKycCompleted"],
        suppyCategory: json["suppyCategory"] == null
            ? null
            : SuppyCategory.fromJson(json["suppyCategory"]),
        kycFinancialData: json["kycFinancialData"] == null
            ? null
            : KycFinancialData.fromJson(json["kycFinancialData"]),
        kycGeneralInfo: json["kycGeneralInfo"] == null
            ? null
            : KycGeneralInfo.fromJson(json["kycGeneralInfo"]),
        kycOrganisationInfo: json["kycOrganisationInfo"] == null
            ? null
            : KycOrganisationInfo.fromJson(json["kycOrganisationInfo"]),
        kycTaxPermits: json["kycTaxPermits"] == null
            ? null
            : KycTaxPermits.fromJson(json["kycTaxPermits"]),
        kycWorkExperience: json["kycWorkExperience"] == null
            ? []
            : List<Map<String, String?>>.from(json["kycWorkExperience"]!.map(
                (x) => Map.from(x)
                    .map((k, v) => MapEntry<String, String?>(k, v)))),
        kycDocuments: json["kycDocuments"] == null
            ? []
            : List<SuppyCategory>.from(
                json["kycDocuments"]!.map((x) => SuppyCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isKycCompleted": isKycCompleted,
        "suppyCategory": suppyCategory?.toJson(),
        "kycFinancialData": kycFinancialData?.toJson(),
        "kycGeneralInfo": kycGeneralInfo?.toJson(),
        "kycOrganisationInfo": kycOrganisationInfo?.toJson(),
        "kycTaxPermits": kycTaxPermits?.toJson(),
        "kycWorkExperience": kycWorkExperience == null
            ? []
            : List<dynamic>.from(kycWorkExperience!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "kycDocuments": kycDocuments == null
            ? []
            : List<dynamic>.from(kycDocuments!.map((x) => x.toJson())),
      };
}

class SuppyCategory {
  SuppyCategory({
    this.id,
    this.userType,
    this.userId,
    this.name,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.categories,
    this.others,
  });

  String? id;
  String? userType;
  String? userId;
  String? name;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? categories;
  dynamic others;

  factory SuppyCategory.fromRawJson(String str) =>
      SuppyCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuppyCategory.fromJson(Map<String, dynamic> json) => SuppyCategory(
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
        categories: json["categories"],
        others: json["others"],
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
        "categories": categories,
        "others": others,
      };
}

class KycFinancialData {
  KycFinancialData({
    this.id,
    this.userType,
    this.userId,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.bankerAddress,
    this.accountType,
    this.overdraftFacility,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userType;
  String? userId;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? bankerAddress;
  String? accountType;
  String? overdraftFacility;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory KycFinancialData.fromRawJson(String str) =>
      KycFinancialData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KycFinancialData.fromJson(Map<String, dynamic> json) =>
      KycFinancialData(
        id: json["id"],
        userType: json["userType"],
        userId: json["userId"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        bankerAddress: json["banker_address"],
        accountType: json["account_type"],
        overdraftFacility: json["overdraft_facility"],
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
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "banker_address": bankerAddress,
        "account_type": accountType,
        "overdraft_facility": overdraftFacility,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class KycGeneralInfo {
  KycGeneralInfo({
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
  String? contactNumber;
  String? regType;
  int? registrationNumber;
  String? businessAddress;
  String? operationalAddress;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory KycGeneralInfo.fromRawJson(String str) =>
      KycGeneralInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KycGeneralInfo.fromJson(Map<String, dynamic> json) => KycGeneralInfo(
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

class KycOrganisationInfo {
  KycOrganisationInfo({
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

  factory KycOrganisationInfo.fromRawJson(String str) =>
      KycOrganisationInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KycOrganisationInfo.fromJson(Map<String, dynamic> json) =>
      KycOrganisationInfo(
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

class KycTaxPermits {
  KycTaxPermits({
    this.id,
    this.userType,
    this.userId,
    this.vat,
    this.tin,
    this.relevantStatutory,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userType;
  String? userId;
  String? vat;
  String? tin;
  dynamic relevantStatutory;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory KycTaxPermits.fromRawJson(String str) =>
      KycTaxPermits.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KycTaxPermits.fromJson(Map<String, dynamic> json) => KycTaxPermits(
        id: json["id"],
        userType: json["userType"],
        userId: json["userId"],
        vat: json["VAT"],
        tin: json["TIN"],
        relevantStatutory: json["relevant_statutory"],
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
        "VAT": vat,
        "TIN": tin,
        "relevant_statutory": relevantStatutory,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
