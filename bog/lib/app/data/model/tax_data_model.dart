// To parse this JSON data, do
//
//     final taxDataModel = taxDataModelFromJson(jsonString);

import 'dart:convert';

class TaxDataModel {
  TaxDataModel({
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
  String? relevantStatutory;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory TaxDataModel.fromRawJson(String str) =>
      TaxDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxDataModel.fromJson(Map<String, dynamic> json) => TaxDataModel(
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
