import 'dart:convert';

class MyOrdersModel {
  MyOrdersModel({
    required this.id,
    required this.orderSlug,
    required this.userId,
    required this.discount,
    required this.deliveryFee,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.orderItems,
    this.refundStatus,
    this.contact,
  });

  String id;
  String orderSlug;
  String userId;
  int discount;
  int deliveryFee;
  int totalAmount;
  String status;
  String? refundStatus;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Contact? contact;
  List<MyOrderItem> orderItems;

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
        refundStatus: json["refundStatus"],
        contact: json["contact"] == null
            ? Contact()
            : Contact.fromJson(json["contact"]),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
        "refundStatus": refundStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
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
  dynamic city;
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
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.image,
    required this.description,
  });

  String id;
  String name;
  String price;
  String unit;
  String image;
  String description;

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
