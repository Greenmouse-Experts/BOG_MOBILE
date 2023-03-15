// To parse this JSON data, do
//
//     final finDataModel = finDataModelFromJson(jsonString);

import 'dart:convert';

class FinDataModel {
  FinDataModel({
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

  factory FinDataModel.fromRawJson(String str) =>
      FinDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FinDataModel.fromJson(Map<String, dynamic> json) => FinDataModel(
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
