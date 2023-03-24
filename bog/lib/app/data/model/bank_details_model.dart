// To parse this JSON data, do
//
//     final bankDetailsModel = bankDetailsModelFromJson(jsonString);

import 'dart:convert';

class BankDetailsModel {
    BankDetailsModel({
        this.accountNumber,
        this.accountName,
        this.bankId,
    });

    String? accountNumber;
    String? accountName;
    int? bankId;

    factory BankDetailsModel.fromRawJson(String str) => BankDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BankDetailsModel.fromJson(Map<String, dynamic> json) => BankDetailsModel(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankId: json["bank_id"],
    );

    Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_id": bankId,
    };
}
