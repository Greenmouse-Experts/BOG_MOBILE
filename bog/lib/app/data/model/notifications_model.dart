// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

class NotificationsModel {
    NotificationsModel({
        this.id,
        this.userId,
        this.type,
        this.message,
        this.isRead,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String? id;
    String? userId;
    String? type;
    String? message;
    bool? isRead;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory NotificationsModel.fromRawJson(String str) => NotificationsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        id: json["id"],
        userId: json["userId"],
        type: json["type"]!,
        message: json["message"],
        isRead: json["isRead"],
        status: json["status"]!,
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "type": type,
        "message": message,
        "isRead": isRead,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}


