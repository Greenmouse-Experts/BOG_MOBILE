// To parse this JSON data, do
//
//     final productReviewModel = productReviewModelFromJson(jsonString);

import 'dart:convert';

class ProductReviewModel {
    ProductReviewModel({
        this.id,
        this.userId,
        this.productId,
        this.star,
        this.review,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String? id;
    String? userId;
    String? productId;
    int? star;
    String? review;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory ProductReviewModel.fromRawJson(String str) => ProductReviewModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductReviewModel.fromJson(Map<String, dynamic> json) => ProductReviewModel(
        id: json["id"],
        userId: json["userId"],
        productId: json["productId"],
        star: json["star"],
        review: json["review"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "productId": productId,
        "star": star,
        "review": review,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
