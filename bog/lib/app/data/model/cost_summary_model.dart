// To parse this JSON data, do
//
//     final costSummaryModel = costSummaryModelFromJson(jsonString);

import 'dart:convert';

class CostSummaryModel {
    CostSummaryModel({
        this.id,
        this.title,
        this.type,
        this.amount,
        this.projectId,
        this.paid,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? title;
    String? type;
    int? amount;
    String? projectId;
    bool? paid;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory CostSummaryModel.fromRawJson(String str) => CostSummaryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CostSummaryModel.fromJson(Map<String, dynamic> json) => CostSummaryModel(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        amount: json["amount"],
        projectId: json["project_id"],
        paid: json["paid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "amount": amount,
        "project_id": projectId,
        "paid": paid,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
