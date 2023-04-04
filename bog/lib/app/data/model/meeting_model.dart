// To parse this JSON data, do
//
//     final meetingModel = meetingModelFromJson(jsonString);

import 'dart:convert';

class MeetingModel {
  MeetingModel({
    this.id,
    this.projectSlug,
    this.meetingSlug,
    this.requestId,
    this.userId,
    this.description,
    this.requestEmail,
    this.status,
    this.approvalStatus,
    this.date,
    this.time,
    this.startUrl,
    this.joinUrl,
    this.recording,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.meetingInfo,
  });

  String? id;
  String? projectSlug;
  String? meetingSlug;
  String? requestId;
  String? userId;
  String? description;
  String? requestEmail;
  String? status;
  String? approvalStatus;
  DateTime? date;
  String? time;
  String? startUrl;
  dynamic joinUrl;
  dynamic recording;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  MeetingInfo? meetingInfo;

  factory MeetingModel.fromRawJson(String str) =>
      MeetingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        id: json["id"],
        projectSlug: json["projectSlug"],
        meetingSlug: json["meetingSlug"],
        requestId: json["requestId"],
        userId: json["userId"],
        description: json["description"],
        requestEmail: json["requestEmail"],
        status: json["status"],
        approvalStatus: json["approval_status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        startUrl: json["start_url"],
        joinUrl: json["join_url"],
        recording: json["recording"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        meetingInfo: json["meeting_info"] == null
            ? null
            : MeetingInfo.fromJson(json["meeting_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectSlug": projectSlug,
        "meetingSlug": meetingSlug,
        "requestId": requestId,
        "userId": userId,
        "description": description,
        "requestEmail": requestEmail,
        "status": status,
        "approval_status": approvalStatus,
        "date": date?.toIso8601String(),
        "time": time,
        "start_url": startUrl,
        "join_url": joinUrl,
        "recording": recording,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "meeting_info": meetingInfo?.toJson(),
      };
}

class MeetingInfo {
  MeetingInfo({
    this.id,
    this.meetingId,
    this.userId,
    this.hostId,
    this.hostEmail,
    this.topic,
    this.status,
    this.password,
    this.joinUrl,
    this.pstnPassword,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? meetingId;
  dynamic userId;
  String? hostId;
  String? hostEmail;
  String? topic;
  String? status;
  String? password;
  String? joinUrl;
  String? pstnPassword;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory MeetingInfo.fromRawJson(String str) =>
      MeetingInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MeetingInfo.fromJson(Map<String, dynamic> json) => MeetingInfo(
        id: json["id"],
        meetingId: json["meetingId"],
        userId: json["userId"],
        hostId: json["host_id"],
        hostEmail: json["host_email"],
        topic: json["topic"],
        status: json["status"],
        password: json["password"],
        joinUrl: json["join_url"],
        pstnPassword: json["pstn_password"],
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
        "meetingId": meetingId,
        "userId": userId,
        "host_id": hostId,
        "host_email": hostEmail,
        "topic": topic,
        "status": status,
        "password": password,
        "join_url": joinUrl,
        "pstn_password": pstnPassword,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
