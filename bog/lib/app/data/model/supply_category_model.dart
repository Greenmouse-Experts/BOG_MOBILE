// To parse this JSON data, do
//
//     final supplyCategory = supplyCategoryFromJson(jsonString);

import 'dart:convert';

class SupplyCategory {
    SupplyCategory({
        this.id,
        this.userType,
        this.userId,
        this.categories,
        this.others,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String? id;
    String? userType;
    String? userId;
    List<String>? categories;
    dynamic others;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory SupplyCategory.fromRawJson(String str) => SupplyCategory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SupplyCategory.fromJson(Map<String, dynamic> json) => SupplyCategory(
        id: json["id"],
        userType: json["userType"],
        userId: json["userId"],
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
        others: json["others"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userType": userType,
        "userId": userId,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
        "others": others,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
