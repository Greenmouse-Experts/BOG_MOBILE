// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

class MessageModel {
  String? id;
  bool? read;
  String? senderId;
  String? recieverId;
  String? message;
  String? conversationId;
  String? updatedAt;

  MessageModel({
    this.id,
    this.read,
    this.senderId,
    this.recieverId,
    this.message,
    this.conversationId,
    this.updatedAt,
  });

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        read: json["read"],
        senderId: json["senderId"],
        recieverId: json["recieverId"],
        message: json["message"],
        conversationId: json["conversationId"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "read": read,
        "senderId": senderId,
        "recieverId": recieverId,
        "message": message,
        "conversationId": conversationId,
        "updatedAt": updatedAt,
      };
}
