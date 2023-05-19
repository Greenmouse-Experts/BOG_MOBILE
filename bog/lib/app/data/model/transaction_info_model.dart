// To parse this JSON data, do
//
//     final transactionInfoModel = transactionInfoModelFromJson(jsonString);

import 'dart:convert';

class TransactionInfoModel {
    Transaction? transaction;
    Detail? detail;

    TransactionInfoModel({
        this.transaction,
        this.detail,
    });

    factory TransactionInfoModel.fromRawJson(String str) => TransactionInfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionInfoModel.fromJson(Map<String, dynamic> json) => TransactionInfoModel(
        transaction: json["transaction"] == null ? null : Transaction.fromJson(json["transaction"]),
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
    );

    Map<String, dynamic> toJson() => {
        "transaction": transaction?.toJson(),
        "detail": detail?.toJson(),
    };
}

class Detail {
    String? id;
    String? orderSlug;
    String? userId;
    String? userType;
    dynamic discount;
    dynamic deliveryFee;
    dynamic totalAmount;
    String? status;
    String? refundStatus;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    List<OrderItem>? orderItems;

    Detail({
        this.id,
        this.orderSlug,
        this.userId,
        this.userType,
        this.discount,
        this.deliveryFee,
        this.totalAmount,
        this.status,
        this.refundStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.orderItems,
    });

    factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        orderSlug: json["orderSlug"],
        userId: json["userId"],
        userType: json["userType"],
        discount: json["discount"],
        deliveryFee: json["deliveryFee"],
        totalAmount: json["totalAmount"],
        status: json["status"],
        refundStatus: json["refundStatus"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderSlug": orderSlug,
        "userId": userId,
        "userType": userType,
        "discount": discount,
        "deliveryFee": deliveryFee,
        "totalAmount": totalAmount,
        "status": status,
        "refundStatus": refundStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
    };
}

class OrderItem {
    ShippingAddress? shippingAddress;
    Product? product;
    PaymentInfo? paymentInfo;
    String? id;
    String? orderId;
    String? trackingId;
    String? status;
    String? ownerId;
    String? productOwner;
    dynamic quantity;
    dynamic discount;
    dynamic amount;
    dynamic deliveryFee;
    dynamic totalAmount;
    dynamic paymentDate;
    dynamic dueDate;
    dynamic returnDate;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    OrderItemUser? user;

    OrderItem({
        this.shippingAddress,
        this.product,
        this.paymentInfo,
        this.id,
        this.orderId,
        this.trackingId,
        this.status,
        this.ownerId,
        this.productOwner,
        this.quantity,
        this.discount,
        this.amount,
        this.deliveryFee,
        this.totalAmount,
        this.paymentDate,
        this.dueDate,
        this.returnDate,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user,
    });

    factory OrderItem.fromRawJson(String str) => OrderItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        shippingAddress: json["shippingAddress"] == null ? null : ShippingAddress.fromJson(json["shippingAddress"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        paymentInfo: json["paymentInfo"] == null ? null : PaymentInfo.fromJson(json["paymentInfo"]),
        id: json["id"],
        orderId: json["orderId"],
        trackingId: json["trackingId"],
        status: json["status"],
        ownerId: json["ownerId"],
        productOwner: json["productOwner"],
        quantity: json["quantity"],
        discount: json["discount"],
        amount: json["amount"],
        deliveryFee: json["deliveryFee"],
        totalAmount: json["totalAmount"],
        paymentDate: json["paymentDate"],
        dueDate: json["dueDate"],
        returnDate: json["returnDate"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        user: json["user"] == null ? null : OrderItemUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "shippingAddress": shippingAddress?.toJson(),
        "product": product?.toJson(),
        "paymentInfo": paymentInfo?.toJson(),
        "id": id,
        "orderId": orderId,
        "trackingId": trackingId,
        "status": status,
        "ownerId": ownerId,
        "productOwner": productOwner,
        "quantity": quantity,
        "discount": discount,
        "amount": amount,
        "deliveryFee": deliveryFee,
        "totalAmount": totalAmount,
        "paymentDate": paymentDate,
        "dueDate": dueDate,
        "returnDate": returnDate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "user": user?.toJson(),
    };
}

class PaymentInfo {
    String? reference;
    dynamic amount;

    PaymentInfo({
        this.reference,
        this.amount,
    });

    factory PaymentInfo.fromRawJson(String str) => PaymentInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        reference: json["reference"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "reference": reference,
        "amount": amount,
    };
}

class Product {
    String? id;
    String? name;
    String? price;
    String? unit;
    String? image;
    String? description;

    Product({
        this.id,
        this.name,
        this.price,
        this.unit,
        this.image,
        this.description,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        unit: json["unit"],
        image: json["image"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "unit": unit,
        "image": image,
        "description": description,
    };
}

class ShippingAddress {
    String? state;
    String? country;
    String? postalCode;
    String? address;
    String? homeAddress;
    String? contactName;
    String? contactEmail;
    String? contactPhone;
    String? deliveryTime;

    ShippingAddress({
        this.state,
        this.country,
        this.postalCode,
        this.address,
        this.homeAddress,
        this.contactName,
        this.contactEmail,
        this.contactPhone,
        this.deliveryTime,
    });

    factory ShippingAddress.fromRawJson(String str) => ShippingAddress.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        address: json["address"],
        homeAddress: json["home_address"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        deliveryTime: json["delivery_time"],
    );

    Map<String, dynamic> toJson() => {
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "address": address,
        "home_address": homeAddress,
        "contact_name": contactName,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "delivery_time": deliveryTime,
    };
}

class OrderItemUser {
    String? id;
    String? name;
    String? email;
    String? fname;
    String? lname;

    OrderItemUser({
        this.id,
        this.name,
        this.email,
        this.fname,
        this.lname,
    });

    factory OrderItemUser.fromRawJson(String str) => OrderItemUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderItemUser.fromJson(Map<String, dynamic> json) => OrderItemUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        fname: json["fname"],
        lname: json["lname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "fname": fname,
        "lname": lname,
    };
}

class Transaction {
    String? id;
    String? transactionId;
    String? userId;
    dynamic amount;
    String? status;
    String? type;
    String? paymentReference;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    TransactionUser? user;

    Transaction({
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

    factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        transactionId: json["TransactionId"],
        userId: json["userId"],
        amount: json["amount"],
        status: json["status"],
        type: json["type"],
        paymentReference: json["paymentReference"],
        description: json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        user: json["user"] == null ? null : TransactionUser.fromJson(json["user"]),
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

class TransactionUser {
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

    TransactionUser({
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

    factory TransactionUser.fromRawJson(String str) => TransactionUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionUser.fromJson(Map<String, dynamic> json) => TransactionUser(
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
