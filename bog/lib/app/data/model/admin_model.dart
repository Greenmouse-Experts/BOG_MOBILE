// To parse this JSON data, do
//
//     final adminModel = adminModelFromJson(jsonString);

import 'dart:convert';

class AdminModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  bool? isActive;
  String? token;
  String? userType;
  dynamic address;
  dynamic state;
  dynamic city;
  dynamic street;
  int? level;
  dynamic photo;
  dynamic fname;
  dynamic lname;
  String? referralId;
  dynamic aboutUs;
  bool? isSuspended;
  String? kycScore;
  String? kycTotal;
  dynamic app;
  dynamic facebookId;
  dynamic googleId;
  dynamic appleId;
  dynamic loginTrials;
  dynamic reasonForSuspension;
  dynamic lastLogin;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  AdminModel({
    this.id,
    this.name,
    this.email,
    this.password,
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
    this.appleId,
    this.loginTrials,
    this.reasonForSuspension,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AdminModel.fromRawJson(String str) =>
      AdminModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
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
        appleId: json["apple_id"],
        loginTrials: json["login_trials"],
        reasonForSuspension: json["reason_for_suspension"],
        lastLogin: json["last_login"],
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
        "password": password,
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
        "apple_id": appleId,
        "login_trials": loginTrials,
        "reason_for_suspension": reasonForSuspension,
        "last_login": lastLogin,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
