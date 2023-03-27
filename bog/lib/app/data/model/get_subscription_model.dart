// To parse this JSON data, do
//
//     final getSubscriptionModel = getSubscriptionModelFromJson(jsonString);

import 'dart:convert';

class GetSubscriptionModel {
    GetSubscriptionModel({
        this.id,
        this.name,
        this.duration,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.benefits,
    });

    String? id;
    String? name;
    int? duration;
    int? amount;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    List<Benefit>? benefits;

    factory GetSubscriptionModel.fromRawJson(String str) => GetSubscriptionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetSubscriptionModel.fromJson(Map<String, dynamic> json) => GetSubscriptionModel(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        amount: json["amount"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        benefits: json["benefits"] == null ? [] : List<Benefit>.from(json["benefits"]!.map((x) => Benefit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "amount": amount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "benefits": benefits == null ? [] : List<dynamic>.from(benefits!.map((x) => x.toJson())),
    };
}

class Benefit {
    Benefit({
        this.id,
        this.planId,
        this.benefit,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String? id;
    String? planId;
    String? benefit;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Benefit.fromRawJson(String str) => Benefit.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
        id: json["id"],
        planId: json["planId"],
        benefit: json["benefit"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "planId": planId,
        "benefit": benefit,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
