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
  });

  String id;
  String orderSlug;
  String userId;
  int discount;
  int deliveryFee;
  int totalAmount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
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


// To parse this JSON data, do
//
//     final myOrders = myOrdersFromJson(jsonString);

// class MyOrdersModel {
//     MyOrdersModel({
//         required this.id,
//         required this.orderSlug,
//         required this.userId,
//         required this.discount,
//         required this.deliveryFee,
//         required this.totalAmount,
//         required this.status,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.deletedAt,
//         required this.contact,
//         required this.orderItems,
//     });

//     final String id;
//     final String orderSlug;
//     final String userId;
//     final int discount;
//     final int deliveryFee;
//     final int totalAmount;
//     final MyOrderStatus status;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final dynamic deletedAt;
//     final Map<String, String> contact;
//     final List<OrderItem> orderItems;

//     factory MyOrdersModel.fromRawJson(String str) => MyOrdersModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
//         id: json["id"],
//         orderSlug: json["orderSlug"],
//         userId: json["userId"],
//         discount: json["discount"],
//         deliveryFee: json["deliveryFee"],
//         totalAmount: json["totalAmount"],
//         status: myOrderStatusValues.map[json["status"]],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//         contact: Map.from(json["contact"]).map((k, v) => MapEntry<String, String>(k, v)),
//         orderItems: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "orderSlug": orderSlug,
//         "userId": userId,
//         "discount": discount,
//         "deliveryFee": deliveryFee,
//         "totalAmount": totalAmount,
//         "status": myOrderStatusValues.reverse[status],
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "deletedAt": deletedAt,
//         "contact": Map.from(contact).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
//     };
// }

// class OrderItem {
//     OrderItem({
//         required this.shippingAddress,
//         required this.product,
//         required this.paymentInfo,
//         required this.id,
//         required this.orderId,
//         required this.trackingId,
//         required this.status,
//         required this.ownerId,
//         required this.productOwner,
//         required this.quantity,
//         required this.discount,
//         required this.amount,
//         required this.deliveryFee,
//         required this.totalAmount,
//         required this.paymentDate,
//         required this.dueDate,
//         required this.returnDate,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.deletedAt,
//         required this.orderItemProductOwner,
//     });

//     final ShippingAddress shippingAddress;
//     final Product product;
//     final PaymentInfo paymentInfo;
//     final String id;
//     final String orderId;
//     final String trackingId;
//     final OrderItemStatus status;
//     final String ownerId;
//     final String productOwner;
//     final int quantity;
//     final dynamic discount;
//     final int amount;
//     final dynamic deliveryFee;
//     final dynamic totalAmount;
//     final dynamic paymentDate;
//     final dynamic dueDate;
//     final dynamic returnDate;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final dynamic deletedAt;
//     final ProductOwner orderItemProductOwner;

//     factory OrderItem.fromRawJson(String str) => OrderItem.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//         shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
//         product: Product.fromJson(json["product"]),
//         paymentInfo: PaymentInfo.fromJson(json["paymentInfo"]),
//         id: json["id"],
//         orderId: json["orderId"],
//         trackingId: json["trackingId"],
//         status: orderItemStatusValues.map[json["status"]],
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
//     );

//     Map<String, dynamic> toJson() => {
//         "shippingAddress": shippingAddress.toJson(),
//         "product": product.toJson(),
//         "paymentInfo": paymentInfo.toJson(),
//         "id": id,
//         "orderId": orderId,
//         "trackingId": trackingId,
//         "status": orderItemStatusValues.reverse[status],
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
//     };
// }

// class ProductOwner {
//     ProductOwner({
//         required this.id,
//         required this.fname,
//         required this.lname,
//         required this.email,
//         required this.phone,
//     });

//     final String id;
//     final String fname;
//     final String lname;
//     final String email;
//     final String phone;

//     factory ProductOwner.fromRawJson(String str) => ProductOwner.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory ProductOwner.fromJson(Map<String, dynamic> json) => ProductOwner(
//         id: json["id"],
//         fname: json["fname"],
//         lname: json["lname"],
//         email: json["email"],
//         phone: json["phone"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "fname": fnameValues.reverse[fname],
//         "lname": lnameValues.reverse[lname],
//         "email": emailValues.reverse[email],
//         "phone": phoneValues.reverse[phone],
//     };
// }

// enum Email { ADMIN_TEST_COM, TEST3_TEST_COM, MEJOMAM375_TEKNOWA_COM, MEYAHA2046_LETPAYS_COM, GREENMOUSEAPP_PRODP_GMAIL_COM, GREENMOUSEAPP_GMAIL_COM }

// final emailValues = EnumValues({
//     "admin@test.com": Email.ADMIN_TEST_COM,
//     "greenmouseapp@gmail.com": Email.GREENMOUSEAPP_GMAIL_COM,
//     "greenmouseapp+prodp@gmail.com": Email.GREENMOUSEAPP_PRODP_GMAIL_COM,
//     "mejomam375@teknowa.com": Email.MEJOMAM375_TEKNOWA_COM,
//     "meyaha2046@letpays.com": Email.MEYAHA2046_LETPAYS_COM,
//     "test3@test.com": Email.TEST3_TEST_COM
// });

// enum Fname { EMPTY, KAREEM, QA_TESTER, QA_PRODUCT, GREENMOUSE_TESTER }

// final fnameValues = EnumValues({
//     "": Fname.EMPTY,
//     "Greenmouse Tester": Fname.GREENMOUSE_TESTER,
//     "Kareem": Fname.KAREEM,
//     "QA Product": Fname.QA_PRODUCT,
//     "QA Tester": Fname.QA_TESTER
// });

// enum Lname { EMPTY, ACE, T, GREENMOUSE, QA_TESTER }

// final lnameValues = EnumValues({
//     "Ace": Lname.ACE,
//     "": Lname.EMPTY,
//     "Greenmouse": Lname.GREENMOUSE,
//     "QA Tester": Lname.QA_TESTER,
//     "T": Lname.T
// });

// enum Phone { EMPTY, THE_08101028981, THE_08052937476, THE_09099989898, THE_08076767656 }

// final phoneValues = EnumValues({
//     "": Phone.EMPTY,
//     "08052937476": Phone.THE_08052937476,
//     "08076767656": Phone.THE_08076767656,
//     "08101028981": Phone.THE_08101028981,
//     "09099989898": Phone.THE_09099989898
// });

// class PaymentInfo {
//     PaymentInfo({
//         required this.reference,
//         required this.amount,
//     });

//     final String reference;
//     final dynamic amount;

//     factory PaymentInfo.fromRawJson(String str) => PaymentInfo.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
//         reference: json["reference"],
//         amount: json["amount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "reference": reference,
//         "amount": amount,
//     };
// }

// class Product {
//     Product({
//         required this.id,
//         required this.name,
//         required this.price,
//         required this.unit,
//         required this.image,
//         required this.description,
//     });

//     final String id;
//     final String name;
//     final String price;
//     final String unit;
//     final String image;
//     final String description;

//     factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//         unit: json["unit"],
//         image: json["image"],
//         description: json["description"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "price": price,
//         "unit": unit,
//         "image": image,
//         "description": description,
//     };
// }

// class ShippingAddress {
//     ShippingAddress({
//         required this.city,
//         required this.state,
//         required this.country,
//         required this.postalCode,
//         required this.address,
//         required this.contactName,
//         required this.contactPhone,
//         required this.contactEmail,
//         required this.homeAddress,
//         required this.deliveryTime,
//     });

//     final City city;
//     final State state;
//     final Country country;
//     final String postalCode;
//     final String address;
//     final String contactName;
//     final String contactPhone;
//     final ContactEmail contactEmail;
//     final String homeAddress;
//     final String deliveryTime;

//     factory ShippingAddress.fromRawJson(String str) => ShippingAddress.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
//         city: cityValues.map[json["city"]],
//         state: stateValues.map[json["state"]],
//         country: countryValues.map[json["country"]],
//         postalCode: json["postal_code"],
//         address: json["address"],
//         contactName: json["contact_name"],
//         contactPhone: json["contact_phone"],
//         contactEmail: contactEmailValues.map[json["contact_email"]],
//         homeAddress: json["home_address"],
//         deliveryTime: json["delivery_time"],
//     );

//     Map<String, dynamic> toJson() => {
//         "city": cityValues.reverse[city],
//         "state": stateValues.reverse[state],
//         "country": countryValues.reverse[country],
//         "postal_code": postalCode,
//         "address": address,
//         "contact_name": contactName,
//         "contact_phone": contactPhone,
//         "contact_email": contactEmailValues.reverse[contactEmail],
//         "home_address": homeAddress,
//         "delivery_time": deliveryTime,
//     };
// }

// enum City { G, IKEJA, LEKKI, CITY_IKEJA, OBOSI }

// final cityValues = EnumValues({
//     "Ikeja ": City.CITY_IKEJA,
//     "g": City.G,
//     "Ikeja": City.IKEJA,
//     "lekki": City.LEKKI,
//     "Obosi": City.OBOSI
// });

// enum ContactEmail { GREENMOUSEAPP_GMAIL_COM, SPIKE_GREENM_COM, NWEKE_GMAIL_COM, INFO_GREENMOUSETECH_COM }

// final contactEmailValues = EnumValues({
//     "greenmouseapp@gmail.com": ContactEmail.GREENMOUSEAPP_GMAIL_COM,
//     "info@greenmousetech.com": ContactEmail.INFO_GREENMOUSETECH_COM,
//     "Nweke@gmail.com": ContactEmail.NWEKE_GMAIL_COM,
//     "spike@greenm.com": ContactEmail.SPIKE_GREENM_COM
// });

// enum Country { H, NIGERIA, NGERIA, NIGHERIA }

// final countryValues = EnumValues({
//     "h": Country.H,
//     "Ngeria": Country.NGERIA,
//     "Nigeria": Country.NIGERIA,
//     "Nigheria": Country.NIGHERIA
// });

// enum State { G, V, LAGOS, STATE_LAGOS, ANAMBRA }

// final stateValues = EnumValues({
//     "Anambra": State.ANAMBRA,
//     "g": State.G,
//     "Lagos": State.LAGOS,
//     "lagos": State.STATE_LAGOS,
//     "v": State.V
// });

// enum OrderItemStatus { PAID }

// final orderItemStatusValues = EnumValues({
//     "paid": OrderItemStatus.PAID
// });

// enum MyOrderStatus { PENDING, COMPLETED }

// final myOrderStatusValues = EnumValues({
//     "completed": MyOrderStatus.COMPLETED,
//     "pending": MyOrderStatus.PENDING
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }
