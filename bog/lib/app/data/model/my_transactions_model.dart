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
    Status? status;
    Type? type;
    String? paymentReference;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    User? user;

    factory MyTransactions.fromRawJson(String str) => MyTransactions.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MyTransactions.fromJson(Map<String, dynamic> json) => MyTransactions(
        id: json["id"],
        transactionId: json["TransactionId"],
        userId: json["userId"],
        amount: json["amount"],
        status: statusValues.map[json["status"]]!,
        type: typeValues.map[json["type"]]!,
        paymentReference: json["paymentReference"],
        description: json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "TransactionId": transactionId,
        "userId": userId,
        "amount": amount,
        "status": statusValues.reverse[status],
        "type": typeValues.reverse[type],
        "paymentReference": paymentReference,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "user": user?.toJson(),
    };
}

enum Status { PAID, SUCCESSFUL }

final statusValues = EnumValues({
    "PAID": Status.PAID,
    "successful": Status.SUCCESSFUL
});

enum Type { PROJECTS, PRODUCTS, SUBSCRIPTION }

final typeValues = EnumValues({
    "Products": Type.PRODUCTS,
    "Projects": Type.PROJECTS,
    "Subscription": Type.SUBSCRIPTION
});

class User {
    User({
        this.name,
        this.photo,
        this.email,
        this.userType,
        this.phone,
    });

    Name? name;
    String? photo;
    Email? email;
    UserType? userType;
    String? phone;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: nameValues.map[json["name"]]!,
        photo: json["photo"],
        email: emailValues.map[json["email"]]!,
        userType: userTypeValues.map[json["userType"]]!,
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "photo": photo,
        "email": emailValues.reverse[email],
        "userType": userTypeValues.reverse[userType],
        "phone": phone,
    };
}

enum Email { GREENMOUSEAPP_QADAN_GMAIL_COM, GREENMOUSEAPP_SP_GMAIL_COM, GREENMOUSEAPP_GMAIL_COM, TEST3_TEST_COM, OLALEYEEMMANUEL23_GMAIL_COM, MEJOMAM375_TEKNOWA_COM }

final emailValues = EnumValues({
    "greenmouseapp@gmail.com": Email.GREENMOUSEAPP_GMAIL_COM,
    "greenmouseapp+qadan@gmail.com": Email.GREENMOUSEAPP_QADAN_GMAIL_COM,
    "greenmouseapp+sp@gmail.com": Email.GREENMOUSEAPP_SP_GMAIL_COM,
    "mejomam375@teknowa.com": Email.MEJOMAM375_TEKNOWA_COM,
    "olaleyeemmanuel23@gmail.com": Email.OLALEYEEMMANUEL23_GMAIL_COM,
    "test3@test.com": Email.TEST3_TEST_COM
});

enum Name { QA_DAN, SUNNY_MBE, EMPTY, TEST_THREE, OLALEYE_EMMANUEL, DANIEL_ADA }

final nameValues = EnumValues({
    "Daniel Ada": Name.DANIEL_ADA,
    " ": Name.EMPTY,
    "Olaleye Emmanuel": Name.OLALEYE_EMMANUEL,
    "QA Dan": Name.QA_DAN,
    "Sunny Mbe": Name.SUNNY_MBE,
    "Test Three": Name.TEST_THREE
});

enum UserType { private_client, professional, corporate_client, vendor }

final userTypeValues = EnumValues({
    "corporate_client": UserType.corporate_client,
    "private_client": UserType.private_client,
    "professional": UserType.professional,
    "vendor": UserType.vendor
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}