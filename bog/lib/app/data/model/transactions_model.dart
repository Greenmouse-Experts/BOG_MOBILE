// To parse this JSON data, do
//
//     final transactionsModel = transactionsModelFromJson(jsonString);

import 'dart:convert';

class TransactionsModel {
  TransactionsModel({
    this.id,
    this.transactionId,
    this.userId,
    this.amount,
    this.status,
    this.type,
    this.paymentReference,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? transactionId;
  String? userId;
  int? amount;
  String? status;
  String? type;
  String? paymentReference;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory TransactionsModel.fromRawJson(String str) =>
      TransactionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        id: json["id"],
        transactionId: json["TransactionId"],
        userId: json["userId"],
        amount: json["amount"],
        status: json["status"]!,
        type: json["type"]!,
        paymentReference: json["paymentReference"],
        description: json["description"],
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
        "TransactionId": transactionId,
        "userId": userId,
        "amount": amount,
        "status": status,
        "type": type,
        "paymentReference": paymentReference,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

//enum Status { PAID, SUCCESSFUL }

// final statusValues =
//     EnumValues({"PAID": Status.PAID, "successful": Status.SUCCESSFUL});

// enum Type { PROJECTS, PRODUCTS }

// final typeValues =
//     EnumValues({"Products": Type.PRODUCTS, "Projects": Type.PROJECTS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
