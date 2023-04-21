// To parse this JSON data, do
//
//     final myTransactions = myTransactionsFromJson(jsonString);

import 'dart:convert';

class MyTransactions {
  MyTransactions({
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
    this.user,
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
  User? user;

  factory MyTransactions.fromRawJson(String str) =>
      MyTransactions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyTransactions.fromJson(Map<String, dynamic> json) => MyTransactions(
        id: json["id"],
        transactionId: json["TransactionId"],
        userId: json["userId"],
        amount: json["amount"],
        status: json["status"],
        type: json["type"],
        paymentReference: json["paymentReference"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.name,
    this.photo,
    this.email,
    this.userType,
    this.phone,
  });

  String? name;
  String? photo;
  String? email;
  String? userType;
  String? phone;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        photo: json["photo"],
        email: json["email"],
        userType: json["userType"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "photo": photo,
        "email": email,
        "userType": userType,
        "phone": phone,
      };
}
