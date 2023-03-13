// To parse this JSON data, do
//
//     final postOrder = postOrderFromJson(jsonString);

import 'dart:convert';

class PostOrder {
    PostOrder({
        required this.products,
        required this.shippingAddress,
        required this.paymentInfo,
        required this.discount,
        required this.deliveryFee,
        required this.totalAmount,
    });

    List<OrderProduct> products;
    ShippingAddress shippingAddress;
    PaymentInfo paymentInfo;
    int discount;
    int deliveryFee;
    int totalAmount;

    factory PostOrder.fromRawJson(String str) => PostOrder.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PostOrder.fromJson(Map<String, dynamic> json) => PostOrder(
        products: List<OrderProduct>.from(json["products"].map((x) => OrderProduct.fromJson(x))),
        shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
        paymentInfo: PaymentInfo.fromJson(json["paymentInfo"]),
        discount: json["discount"],
        deliveryFee: json["deliveryFee"],
        totalAmount: json["totalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "shippingAddress": shippingAddress.toJson(),
        "paymentInfo": paymentInfo.toJson(),
        "discount": discount,
        "deliveryFee": deliveryFee,
        "totalAmount": totalAmount,
    };
}

class PaymentInfo {
    PaymentInfo({
        required this.reference,
        required this.amount,
    });

    String reference;
    int amount;

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

class OrderProduct {
    OrderProduct({
        required this.productId,
        required this.quantity,
    });

    String productId;
    int quantity;

    factory OrderProduct.fromRawJson(String str) => OrderProduct.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        productId: json["productId"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
    };
}

class ShippingAddress {
    ShippingAddress({
        required this.city,
        required this.state,
        required this.country,
        required this.postalCode,
        required this.address,
        required this.contactName,
        required this.contactPhone,
        required this.contactEmail,
    });

    String city;
    String state;
    String country;
    String postalCode;
    String address;
    String contactName;
    String contactPhone;
    String contactEmail;

    factory ShippingAddress.fromRawJson(String str) => ShippingAddress.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
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
