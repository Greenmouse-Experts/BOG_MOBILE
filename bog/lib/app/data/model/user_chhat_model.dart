// To parse this JSON data, do
//
//     final userChatModel = userChatModelFromJson(jsonString);

import 'dart:convert';

class UserChatModel {
  List<String>? participantsId;
  String? id;
  String? userId;
  String? conversationtype;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<ChatMessage>? chatMessages;

  UserChatModel({
    this.participantsId,
    this.id,
    this.userId,
    this.conversationtype,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.chatMessages,
  });

  factory UserChatModel.fromRawJson(String str) =>
      UserChatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

    static List<UserChatModel> getList(List<dynamic> val) {
    return val.map((e) => UserChatModel.fromJson(e)).toList();
  }

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
        participantsId: json["participantsId"] == null
            ? []
            : List<String>.from(json["participantsId"]!.map((x) => x)),
        id: json["id"],
        userId: json["userId"],
        conversationtype: json["conversationtype"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        chatMessages: json["chatMessages"] == null
            ? []
            : List<ChatMessage>.from(
                json["chatMessages"]!.map((x) => ChatMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "participantsId": participantsId == null
            ? []
            : List<dynamic>.from(participantsId!.map((x) => x)),
        "id": id,
        "userId": userId,
        "conversationtype": conversationtype,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "chatMessages": chatMessages == null
            ? []
            : List<dynamic>.from(chatMessages!.map((x) => x.toJson())),
      };
}

class ChatMessage {
  String? id;
  String? conversationId;
  String? senderId;
  String? recieverId;
  String? message;
  dynamic attachment;
  bool? read;
  DateTime? updatedAt;

  ChatMessage({
    this.id,
    this.conversationId,
    this.senderId,
    this.recieverId,
    this.message,
    this.attachment,
    this.read,
    this.updatedAt,
  });

  factory ChatMessage.fromRawJson(String str) =>
      ChatMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        conversationId: json["conversationId"],
        senderId: json["senderId"],
        recieverId: json["recieverId"],
        message: json["message"],
        attachment: json["attachment"],
        read: json["read"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversationId": conversationId,
        "senderId": senderId,
        "recieverId": recieverId,
        "message": message,
        "attachment": attachment,
        "read": read,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
