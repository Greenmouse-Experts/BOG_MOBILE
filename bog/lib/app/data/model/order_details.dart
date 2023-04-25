//

// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

class OrderDetailsModel {
  OrderDetailsModel({
    this.id,
    this.orderSlug,
    this.userId,
    this.discount,
    this.deliveryFee,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.contact,
    this.orderItems,
    this.client,
    this.orderReview,
  });

  String? id;
  String? orderSlug;
  String? userId;
  int? discount;
  int? deliveryFee;
  int? totalAmount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Contact? contact;
  List<OrderDetailItem>? orderItems;
  Client? client;
  List<OrderReview>? orderReview;

  factory OrderDetailsModel.fromRawJson(String str) =>
      OrderDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        orderSlug: json["orderSlug"],
        userId: json["userId"],
        discount: json["discount"],
        deliveryFee: json["deliveryFee"],
        totalAmount: json["totalAmount"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderDetailItem>.from(
                json["order_items"]!.map((x) => OrderDetailItem.fromJson(x))),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        orderReview: json["orderReview"] == null
            ? []
            : List<OrderReview>.from(
                json["orderReview"]!.map((x) => OrderReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderSlug": orderSlug,
        "userId": userId,
        "discount": discount,
        "deliveryFee": deliveryFee,
        "totalAmount": totalAmount,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "contact": contact?.toJson(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "client": client?.toJson(),
        "orderReview": orderReview == null
            ? []
            : List<dynamic>.from(orderReview!.map((x) => x)),
      };
}

class Client {
  Client({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.photo,
  });

  String? id;
  String? fname;
  String? lname;
  String? email;
  String? phone;
  String? photo;

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        phone: json["phone"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "phone": phone,
        "photo": photo,
      };
}

class Contact {
  Contact({
    this.id,
    this.orderId,
    this.userId,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? orderId;
  String? userId;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        orderId: json["orderId"],
        userId: json["userId"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
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
        "orderId": orderId,
        "userId": userId,
        "contact_name": contactName,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class OrderDetailItem {
  OrderDetailItem({
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
    this.orderItemProductOwner,
  });

  ShippingAddress? shippingAddress;
  Product? product;
  PaymentInfo? paymentInfo;
  String? id;
  String? orderId;
  String? trackingId;
  String? status;
  String? ownerId;
  String? productOwner;
  int? quantity;
  dynamic discount;
  int? amount;
  dynamic deliveryFee;
  dynamic totalAmount;
  dynamic paymentDate;
  dynamic dueDate;
  dynamic returnDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Client? orderItemProductOwner;

  factory OrderDetailItem.fromRawJson(String str) =>
      OrderDetailItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailItem.fromJson(Map<String, dynamic> json) =>
      OrderDetailItem(
        shippingAddress: json["shippingAddress"] == null
            ? null
            : ShippingAddress.fromJson(json["shippingAddress"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        paymentInfo: json["paymentInfo"] == null
            ? null
            : PaymentInfo.fromJson(json["paymentInfo"]),
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        orderItemProductOwner: json["product_owner"] == null
            ? null
            : Client.fromJson(json["product_owner"]),
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
        "product_owner": orderItemProductOwner?.toJson(),
      };
}

class PaymentInfo {
  PaymentInfo({
    this.reference,
    this.amount,
  });

  String? reference;
  dynamic amount;

  factory PaymentInfo.fromRawJson(String str) =>
      PaymentInfo.fromJson(json.decode(str));

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
  Product({
    this.id,
    this.name,
    this.price,
    this.unit,
    this.image,
    this.description,
  });

  String? id;
  String? name;
  String? price;
  String? unit;
  String? image;
  String? description;

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
  ShippingAddress({
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.address,
    this.contactName,
    this.contactPhone,
    this.contactEmail,
  });

  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? address;
  String? contactName;
  String? contactPhone;
  String? contactEmail;

  factory ShippingAddress.fromRawJson(String str) =>
      ShippingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        address: json["address"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        contactEmail: json["contact_email"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "address": address,
        "contact_name": contactName,
        "contact_phone": contactPhone,
        "contact_email": contactEmail,
      };
}

class OrderReview {
  OrderReview({
    this.id,
    this.star,
    this.review,
    this.userId,
    this.orderId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  int? star;
  String? review;
  String? userId;
  String? orderId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OrderReview.fromRawJson(String str) =>
      OrderReview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderReview.fromJson(Map<String, dynamic> json) => OrderReview(
        id: json["id"],
        star: json["star"],
        review: json["review"],
        userId: json["userId"],
        orderId: json["orderId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "star": star,
        "review": review,
        "userId": userId,
        "orderId": orderId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
