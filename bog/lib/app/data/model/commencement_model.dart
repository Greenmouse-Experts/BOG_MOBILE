

import 'dart:convert';

class CommencementFeeModel {
    CommencementFeeModel({
        this.title,
        this.amount,
        this.createdAt,
        this.updatedAt,
    });

    String? title;
    int? amount;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory CommencementFeeModel.fromRawJson(String str) => CommencementFeeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CommencementFeeModel.fromJson(Map<String, dynamic> json) => CommencementFeeModel(
        title: json["title"],
        amount: json["amount"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
