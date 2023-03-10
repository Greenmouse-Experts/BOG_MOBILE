// // To parse this JSON data, do
// //
// //     final myOrders = myOrdersFromJson(jsonString);

import 'dart:convert';

// class MyOrdersModel {
//   MyOrdersModel({
//     required this.id,
//     required this.orderSlug,
//     required this.userId,
//     required this.discount,
//     required this.deliveryFee,
//     required this.totalAmount,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deletedAt,
//     required this.orderItems,
//   });

//   final String id;
//   final String orderSlug;
//   final String userId;
//   final int discount;
//   final int deliveryFee;
//   final int totalAmount;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final dynamic deletedAt;
//   final List<MyOrderItem> orderItems;

//   factory MyOrdersModel.fromRawJson(String str) =>
//       MyOrdersModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
//         id: json["id"],
//         orderSlug: json["orderSlug"],
//         userId: json["userId"],
//         discount: json["discount"],
//         deliveryFee: json["deliveryFee"],
//         totalAmount: json["totalAmount"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//         orderItems: List<MyOrderItem>.from(
//             json["order_items"].map((x) => MyOrderItem.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "orderSlug": orderSlug,
//         "userId": userId,
//         "discount": discount,
//         "deliveryFee": deliveryFee,
//         "totalAmount": totalAmount,
//         "status": status,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "deletedAt": deletedAt,
//         "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
//       };

//   static List<MyOrdersModel> fromJsonList(List list) {
//     if (list.isEmpty) return [];
//     return list.map((item) => MyOrdersModel.fromJson(item)).toList();
//   }
// }

// class MyOrderItem {
//   MyOrderItem({
//     required this.shippingAddress,
//     required this.product,
//     required this.paymentInfo,
//     required this.id,
//     required this.orderId,
//     required this.trackingId,
//     required this.status,
//     required this.ownerId,
//     required this.productOwner,
//     required this.quantity,
//     required this.discount,
//     required this.amount,
//     required this.deliveryFee,
//     required this.totalAmount,
//     required this.paymentDate,
//     required this.dueDate,
//     required this.returnDate,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deletedAt,
//     required this.orderItemProductOwner,
//   });

//   final ShippingAddress shippingAddress;
//   final Product product;
//   final PaymentInfo paymentInfo;
//   final String id;
//   final String orderId;
//   final String trackingId;
//   final String status;
//   final String ownerId;
//   final String productOwner;
//   final int quantity;
//   final dynamic discount;
//   final int amount;
//   final dynamic deliveryFee;
//   final dynamic totalAmount;
//   final dynamic paymentDate;
//   final dynamic dueDate;
//   final dynamic returnDate;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final dynamic deletedAt;
//   final ProductOwner orderItemProductOwner;

//   factory MyOrderItem.fromRawJson(String str) =>
//       MyOrderItem.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MyOrderItem.fromJson(Map<String, dynamic> json) => MyOrderItem(
//         shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
//         product: Product.fromJson(json["product"]),
//         paymentInfo: PaymentInfo.fromJson(json["paymentInfo"]),
//         id: json["id"],
//         orderId: json["orderId"],
//         trackingId: json["trackingId"],
//         status: json["status"],
//         ownerId: json["ownerId"],
//         productOwner: json["productOwner"],
//         quantity: json["quantity"],
//         discount: json["discount"],
//         amount: json["amount"],
//         deliveryFee: json["deliveryFee"],
//         totalAmount: json["totalAmount"],
//         paymentDate: json["paymentDate"],
//         dueDate: json["dueDate"],
//         returnDate: json["returnDate"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//         orderItemProductOwner: ProductOwner.fromJson(json["product_owner"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "shippingAddress": shippingAddress.toJson(),
//         "product": product.toJson(),
//         "paymentInfo": paymentInfo.toJson(),
//         "id": id,
//         "orderId": orderId,
//         "trackingId": trackingId,
//         "status": status,
//         "ownerId": ownerId,
//         "productOwner": productOwner,
//         "quantity": quantity,
//         "discount": discount,
//         "amount": amount,
//         "deliveryFee": deliveryFee,
//         "totalAmount": totalAmount,
//         "paymentDate": paymentDate,
//         "dueDate": dueDate,
//         "returnDate": returnDate,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "deletedAt": deletedAt,
//         "product_owner": orderItemProductOwner.toJson(),
//       };
// }

// class ProductOwner {
//   ProductOwner({
//     required this.id,
//     required this.fname,
//     required this.lname,
//     required this.email,
//     required this.phone,
//   });

//   final String id;
//   final String fname;
//   final String lname;
//   final String email;
//   final String phone;

//   factory ProductOwner.fromRawJson(String str) =>
//       ProductOwner.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ProductOwner.fromJson(Map<String, dynamic> json) => ProductOwner(
//         id: json["id"],
//         fname: json["fname"],
//         lname: json["lname"],
//         email: json["email"],
//         phone: json["phone"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "fname": fname,
//         "lname": lname,
//         "email": email,
//         "phone": phone,
//       };
// }

// class PaymentInfo {
//   PaymentInfo({
//     required this.reference,
//     required this.amount,
//   });

//   final String reference;
//   final int amount;

//   factory PaymentInfo.fromRawJson(String str) =>
//       PaymentInfo.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
//         reference: json["reference"],
//         amount: json["amount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "reference": reference,
//         "amount": amount,
//       };
// }

// class Product {
//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.unit,
//     required this.image,
//     required this.description,
//   });

//   final String id;
//   final String name;
//   final String price;
//   final String unit;
//   final String image;
//   final String description;

//   factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//         unit: json["unit"],
//         image: json["image"],
//         description: json["description"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "price": price,
//         "unit": unit,
//         "image": image,
//         "description": description,
//       };
// }

// class ShippingAddress {
//   ShippingAddress({
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.postalCode,
//   });

//   final String city;
//   final String state;
//   final String country;
//   final String postalCode;

//   factory ShippingAddress.fromRawJson(String str) =>
//       ShippingAddress.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
//       ShippingAddress(
//         city: json["city"],
//         state: json["state"],
//         country: json["country"],
//         postalCode: json["postal_code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "city": city,
//         "state": state,
//         "country": country,
//         "postal_code": postalCode,
//       };
// }

// To parse this JSON data, do

//     final myOrders = myOrdersFromJson(jsonString);

import 'dart:convert';

class MyOrdersModel {
  MyOrdersModel({
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
    this.orderItems,
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
  List<MyOrderItem>? orderItems;

  factory MyOrdersModel.fromRawJson(String str) =>
      MyOrdersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
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
        orderItems: json["order_items"] == null
            ? []
            : List<MyOrderItem>.from(
                json["order_items"]!.map((x) => MyOrderItem.fromJson(x))),
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
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class MyOrderItem {
  MyOrderItem({
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
  ProductOwner? orderItemProductOwner;

  factory MyOrderItem.fromRawJson(String str) =>
      MyOrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyOrderItem.fromJson(Map<String, dynamic> json) => MyOrderItem(
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
            : ProductOwner.fromJson(json["product_owner"]),
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

class ProductOwner {
  ProductOwner({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.phone,
  });

  String? id;
  String? fname;
  String? lname;
  String? email;
  String? phone;

  factory ProductOwner.fromRawJson(String str) =>
      ProductOwner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductOwner.fromJson(Map<String, dynamic> json) => ProductOwner(
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "phone": phone,
      };
}

class PaymentInfo {
  PaymentInfo({
    this.reference,
    this.amount,
  });

  String? reference;
  int? amount;

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
  });

  String? city;
  String? state;
  String? country;
  String? postalCode;

  factory ShippingAddress.fromRawJson(String str) =>
      ShippingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
      };
}
