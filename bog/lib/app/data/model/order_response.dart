// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

class OrderResponse {
  OrderResponse({
    this.id,
    this.status,
    this.orderSlug,
    this.userId,
    this.deliveryFee,
    this.discount,
    this.totalAmount,
    this.orderItems,
    this.contact,
    this.updatedAt,
    this.createdAt,
  });

  String? id;
  String? status;
  String? orderSlug;
  String? userId;
  dynamic deliveryFee;
  dynamic discount;
  dynamic totalAmount;
  List<OrderItem>? orderItems;
  Contact? contact;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory OrderResponse.fromRawJson(String str) =>
      OrderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        id: json["id"],
        status: json["status"],
        orderSlug: json["orderSlug"],
        userId: json["userId"],
        deliveryFee: json["deliveryFee"],
        discount: json["discount"],
        totalAmount: json["totalAmount"],
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromJson(x))),
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "orderSlug": orderSlug,
        "userId": userId,
        "deliveryFee": deliveryFee,
        "discount": discount,
        "totalAmount": totalAmount,
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "contact": contact?.toJson(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}

class Contact {
  Contact({
    this.id,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.address,
    this.contactName,
    this.contactPhone,
    this.contactEmail,
    this.userId,
    this.orderId,
    this.updatedAt,
    this.createdAt,
  });

  String? id;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? address;
  String? contactName;
  String? contactPhone;
  String? contactEmail;
  String? userId;
  String? orderId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        address: json["address"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        contactEmail: json["contact_email"],
        userId: json["userId"],
        orderId: json["orderId"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "address": address,
        "contact_name": contactName,
        "contact_phone": contactPhone,
        "contact_email": contactEmail,
        "userId": userId,
        "orderId": orderId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}

class OrderItem {
  OrderItem({
    this.shippingAddress,
    this.product,
    this.paymentInfo,
    this.id,
    this.status,
    this.trackingId,
    this.ownerId,
    this.productOwner,
    this.amount,
    this.quantity,
    this.orderId,
    this.updatedAt,
    this.createdAt,
  });

  ShippingAddress? shippingAddress;
  Product? product;
  PaymentInfo? paymentInfo;
  String? id;
  String? status;
  String? trackingId;
  String? ownerId;
  String? productOwner;
  dynamic amount;
  dynamic quantity;
  String? orderId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        shippingAddress: json["shippingAddress"] == null
            ? null
            : ShippingAddress.fromJson(json["shippingAddress"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        paymentInfo: json["paymentInfo"] == null
            ? null
            : PaymentInfo.fromJson(json["paymentInfo"]),
        id: json["id"],
        status: json["status"],
        trackingId: json["trackingId"],
        ownerId: json["ownerId"],
        productOwner: json["productOwner"],
        amount: json["amount"],
        quantity: json["quantity"],
        orderId: json["orderId"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "shippingAddress": shippingAddress?.toJson(),
        "product": product?.toJson(),
        "paymentInfo": paymentInfo?.toJson(),
        "id": id,
        "status": status,
        "trackingId": trackingId,
        "ownerId": ownerId,
        "productOwner": productOwner,
        "amount": amount,
        "quantity": quantity,
        "orderId": orderId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
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
