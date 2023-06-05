// To parse this JSON data, do
//
//     final compProdReviewModel = compProdReviewModelFromJson(jsonString);

import 'dart:convert';

class CompProdReviewModel {
    List<Review>? reviews;
    int? star;

    CompProdReviewModel({
        this.reviews,
        this.star,
    });

    factory CompProdReviewModel.fromRawJson(String str) => CompProdReviewModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CompProdReviewModel.fromJson(Map<String, dynamic> json) => CompProdReviewModel(
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        star: json["star"],
    );

    Map<String, dynamic> toJson() => {
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "star": star,
    };
}

class Review {
    String? id;
    String? userId;
    String? productId;
    int? star;
    String? review;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    Client? client;

    Review({
        this.id,
        this.userId,
        this.productId,
        this.star,
        this.review,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.client,
    });

    factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userId"],
        productId: json["productId"],
        star: json["star"],
        review: json["review"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
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
        "client": client?.toJson(),
    };
}

class Client {
    String? id;
    String? name;
    String? email;
    String? password;
    String? phone;
    bool? isActive;
    String? token;
    String? userType;
    String? address;
    String? state;
    String? city;
    dynamic street;
    int? level;
    String? photo;
    String? fname;
    String? lname;
    String? referralId;
    String? aboutUs;
    bool? isSuspended;
    String? kycScore;
    String? kycTotal;
    dynamic app;
    dynamic facebookId;
    dynamic googleId;
    dynamic appleId;
    dynamic loginTrials;
    dynamic reasonForSuspension;
    DateTime? lastLogin;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    Client({
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

    factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Client.fromJson(Map<String, dynamic> json) => Client(
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
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "last_login": "${lastLogin!.year.toString().padLeft(4, '0')}-${lastLogin!.month.toString().padLeft(2, '0')}-${lastLogin!.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
