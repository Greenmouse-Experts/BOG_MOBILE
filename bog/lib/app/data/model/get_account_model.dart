// To parse this JSON data, do
//
//     final getAccountModel = getAccountModelFromJson(jsonString);

import 'dart:convert';

class GetAccountModel {
  GetAccountModel({
    this.id,
    this.userId,
    this.userType,
  });

  String? id;
  String? userId;
  String? userType;

  factory GetAccountModel.fromRawJson(String str) =>
      GetAccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAccountModel.fromJson(Map<String, dynamic> json) =>
      GetAccountModel(
        id: json["id"],
        userId: json["userId"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userType": userType,
      };
}
