// To parse this JSON data, do
//
//     final clientProjectModel = clientProjectModelFromJson(jsonString);

import 'dart:convert';

class ClientProjectModel {
  ClientProjectModel({
    this.id,
    this.userId,
    this.title,
    this.projectSlug,
    this.description,
    this.projectTypes,
    this.status,
    this.approvalStatus,
    this.serviceProviderId,
    this.totalCost,
    this.estimatedCost,
    this.duration,
    this.progress,
    this.servicePartnerProgress,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.serviceProvider,
    this.clientDetails,
    this.projectData,
    this.reviews,
    this.client,
    this.transactions,
  });

  String? id;
  String? userId;
  String? title;
  String? projectSlug;
  dynamic description;
  String? projectTypes;
  String? status;
  String? approvalStatus;
  dynamic serviceProviderId;
  int? totalCost;
  int? estimatedCost;
  int? duration;
  int? progress;
  dynamic servicePartnerProgress;
  dynamic endDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic serviceProvider;
  ClientDetails? clientDetails;
  List<ProjectDatum>? projectData;
  List<dynamic>? reviews;
  Client? client;
  Transactions? transactions;

  factory ClientProjectModel.fromRawJson(String str) =>
      ClientProjectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientProjectModel.fromJson(Map<String, dynamic> json) =>
      ClientProjectModel(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        projectSlug: json["projectSlug"],
        description: json["description"],
        projectTypes: json["projectTypes"],
        status: json["status"],
        approvalStatus: json["approvalStatus"],
        serviceProviderId: json["serviceProviderId"],
        totalCost: json["totalCost"],
        estimatedCost: json["estimatedCost"],
        duration: json["duration"],
        progress: json["progress"],
        servicePartnerProgress: json["service_partner_progress"],
        endDate: json["endDate"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        serviceProvider: json["serviceProvider"],
        clientDetails: json["clientDetails"] == null
            ? null
            : ClientDetails.fromJson(json["clientDetails"]),
        projectData: json["projectData"] == null
            ? []
            : List<ProjectDatum>.from(
                json["projectData"]!.map((x) => ProjectDatum.fromJson(x))),
        reviews: json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        transactions: json["transactions"] == null
            ? null
            : Transactions.fromJson(json["transactions"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "projectSlug": projectSlug,
        "description": description,
        "projectTypes": projectTypes,
        "status": status,
        "approvalStatus": approvalStatus,
        "serviceProviderId": serviceProviderId,
        "totalCost": totalCost,
        "estimatedCost": estimatedCost,
        "duration": duration,
        "progress": progress,
        "service_partner_progress": servicePartnerProgress,
        "endDate": endDate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "serviceProvider": serviceProvider,
        "clientDetails": clientDetails?.toJson(),
        "projectData": projectData == null
            ? []
            : List<dynamic>.from(projectData!.map((x) => x.toJson())),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "client": client?.toJson(),
        "transactions": transactions?.toJson(),
      };
}

class Client {
  Client({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isActive,
    this.token,
    this.userType,
    this.address,
    this.state,
    this.city,
    this.street,
    this.level,
    this.photo,
    this.fname,
    this.lname,
    this.referralId,
    this.aboutUs,
    this.isSuspended,
    this.kycScore,
    this.kycTotal,
    this.app,
    this.facebookId,
    this.googleId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? name;
  String? email;
  String? phone;
  bool? isActive;
  dynamic token;
  String? userType;
  dynamic address;
  dynamic state;
  dynamic city;
  dynamic street;
  int? level;
  String? photo;
  String? fname;
  String? lname;
  String? referralId;
  dynamic aboutUs;
  bool? isSuspended;
  dynamic kycScore;
  dynamic kycTotal;
  dynamic app;
  dynamic facebookId;
  dynamic googleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        isActive: json["isActive"],
        token: json["token"],
        userType: json["userType"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        street: json["street"],
        level: json["level"],
        photo: json["photo"],
        fname: json["fname"],
        lname: json["lname"],
        referralId: json["referralId"],
        aboutUs: json["aboutUs"],
        isSuspended: json["isSuspended"],
        kycScore: json["kycScore"],
        kycTotal: json["kycTotal"],
        app: json["app"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
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
        "name": name,
        "email": email,
        "phone": phone,
        "isActive": isActive,
        "token": token,
        "userType": userType,
        "address": address,
        "state": state,
        "city": city,
        "street": street,
        "level": level,
        "photo": photo,
        "fname": fname,
        "lname": lname,
        "referralId": referralId,
        "aboutUs": aboutUs,
        "isSuspended": isSuspended,
        "kycScore": kycScore,
        "kycTotal": kycTotal,
        "app": app,
        "facebook_id": facebookId,
        "google_id": googleId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class ClientDetails {
  ClientDetails();

  factory ClientDetails.fromRawJson(String str) =>
      ClientDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientDetails.fromJson(Map<String, dynamic> json) => ClientDetails();

  Map<String, dynamic> toJson() => {};
}

class ProjectDatum {
  ProjectDatum({
    this.id,
    this.userId,
    this.projectId,
    this.serviceFormId,
    this.value,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.serviceForm,
  });

  String? id;
  String? userId;
  String? projectId;
  String? serviceFormId;
  String? value;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  ServiceForm? serviceForm;

  factory ProjectDatum.fromRawJson(String str) =>
      ProjectDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectDatum.fromJson(Map<String, dynamic> json) => ProjectDatum(
        id: json["id"],
        userId: json["userID"],
        projectId: json["projectID"],
        serviceFormId: json["serviceFormID"],
        value: json["value"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        serviceForm: json["serviceForm"] == null
            ? null
            : ServiceForm.fromJson(json["serviceForm"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "projectID": projectId,
        "serviceFormID": serviceFormId,
        "value": value,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "serviceForm": serviceForm?.toJson(),
      };
}

class ServiceForm {
  ServiceForm({
    this.id,
    this.serviceTypeId,
    this.serviceName,
    this.label,
    this.inputType,
    this.placeholder,
    this.name,
    this.value,
    this.required,
    this.isActive,
    this.access,
    this.inline,
    this.toggle,
    this.other,
    this.subLabel,
    this.selected,
    this.className,
    this.requireValidOption,
    this.multiple,
    this.subtype,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? serviceTypeId;
  String? serviceName;
  String? label;
  String? inputType;
  dynamic placeholder;
  String? name;
  String? value;
  dynamic required;
  bool? isActive;
  dynamic access;
  dynamic inline;
  dynamic toggle;
  dynamic other;
  String? subLabel;
  dynamic selected;
  String? className;
  dynamic requireValidOption;
  dynamic multiple;
  String? subtype;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ServiceForm.fromRawJson(String str) =>
      ServiceForm.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceForm.fromJson(Map<String, dynamic> json) => ServiceForm(
        id: json["id"],
        serviceTypeId: json["serviceTypeID"],
        serviceName: json["serviceName"],
        label: json["label"],
        inputType: json["inputType"],
        placeholder: json["placeholder"],
        name: json["name"],
        value: json["value"],
        required: json["required"],
        isActive: json["isActive"],
        access: json["access"],
        inline: json["inline"],
        toggle: json["toggle"],
        other: json["other"],
        subLabel: json["subLabel"],
        selected: json["selected"],
        className: json["className"],
        requireValidOption: json["requireValidOption"],
        multiple: json["multiple"],
        subtype: json["subtype"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceTypeID": serviceTypeId,
        "serviceName": serviceName,
        "label": label,
        "inputType": inputType,
        "placeholder": placeholder,
        "name": name,
        "value": value,
        "required": required,
        "isActive": isActive,
        "access": access,
        "inline": inline,
        "toggle": toggle,
        "other": other,
        "subLabel": subLabel,
        "selected": selected,
        "className": className,
        "requireValidOption": requireValidOption,
        "multiple": multiple,
        "subtype": subtype,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Transactions {
  Transactions({
    this.commitmentFee,
  });

  ClientDetails? commitmentFee;

  factory Transactions.fromRawJson(String str) =>
      Transactions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        commitmentFee: json["commitmentFee"] == null
            ? null
            : ClientDetails.fromJson(json["commitmentFee"]),
      );

  Map<String, dynamic> toJson() => {
        "commitmentFee": commitmentFee?.toJson(),
      };
}
