// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

class UserDetailsModel {
  UserDetailsModel({
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.profile,
  });

  String? id;
  String? name;
  String? email;
  String? password;
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
  String? kycScore;
  String? kycTotal;
  dynamic app;
  dynamic facebookId;
  dynamic googleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Profile? profile;

  factory UserDetailsModel.fromRawJson(String str) =>
      UserDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "profile": profile?.toJson(),
      };
}

class Profile {
  Profile({
    this.id,
    this.userId,
    this.userType,
    this.isVerified,
    this.companyAddress,
    this.companyState,
    this.companyCity,
    this.companyStreet,
    this.companyName,
    this.cacNumber,
    this.tin,
    this.bvn,
    this.yearsOfExperience,
    this.certificateOfOperation,
    this.professionalCertificate,
    this.taxCertificate,
    this.serviceTypeId,
    this.kycPoint,
    this.planId,
    this.rating,
    this.expiredAt,
    this.hasActiveSubscription,
    this.serviceCategory,
  });

  String? id;
  String? userId;
  String? userType;
  bool? isVerified;
  dynamic companyAddress;
  dynamic companyState;
  dynamic companyCity;
  dynamic companyStreet;
  String? companyName;
  dynamic rating;
  dynamic cacNumber;
  dynamic tin;
  dynamic bvn;
  dynamic yearsOfExperience;
  dynamic certificateOfOperation;
  dynamic professionalCertificate;
  dynamic taxCertificate;
  dynamic serviceTypeId;
  int? kycPoint;
  String? planId;
  DateTime? expiredAt;
  bool? hasActiveSubscription;
  dynamic serviceCategory;

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        userId: json["userId"],
        userType: json["userType"],
        isVerified: json["isVerified"],
        companyAddress: json["company_address"],
        companyState: json["company_state"],
        companyCity: json["company_city"],
        rating: json["rating"],
        companyStreet: json["company_street"],
        companyName: json["company_name"],
        cacNumber: json["cac_number"],
        tin: json["tin"],
        bvn: json["bvn"],
        yearsOfExperience: json["years_of_experience"],
        certificateOfOperation: json["certificate_of_operation"],
        professionalCertificate: json["professional_certificate"],
        taxCertificate: json["tax_certificate"],
        serviceTypeId: json["serviceTypeId"],
        kycPoint: json["kycPoint"],
        planId: json["planId"],
        expiredAt: json["expiredAt"] == null
            ? null
            : DateTime.parse(json["expiredAt"]),
        hasActiveSubscription: json["hasActiveSubscription"],
        serviceCategory: json["service_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userType": userType,
        "isVerified": isVerified,
        "company_address": companyAddress,
        "company_state": companyState,
        "company_city": companyCity,
        "company_street": companyStreet,
        "company_name": companyName,
        "cac_number": cacNumber,
        "tin": tin,
        "bvn": bvn,
        "rating": rating,
        "years_of_experience": yearsOfExperience,
        "certificate_of_operation": certificateOfOperation,
        "professional_certificate": professionalCertificate,
        "tax_certificate": taxCertificate,
        "serviceTypeId": serviceTypeId,
        "kycPoint": kycPoint,
        "planId": planId,
        "expiredAt": expiredAt?.toIso8601String(),
        "hasActiveSubscription": hasActiveSubscription,
        "service_category": serviceCategory,
      };
}
