import 'dart:convert';

// import 'product_review_model.dart';
// /// id : "890e8d35-5389-4435-be77-518af43e1c9f"
// /// name : "80 Bags of Dangote Cement 8"
// /// description : "Consequat mollit commodo laboris amet est occaecat velit velit proident enim nulla eu. Deserunt consectetur cillum irure magna cillum elit mollit nulla. Ullamco commodo irure est aliquip qui anim qui occaecat magna"
// /// categoryId : "84c25973-1770-4136-ab01-9084e9fddf92"
// /// creatorId : "d2732310-d41a-4b64-870c-8734b0f560dd"
// /// price : "90000"
// /// quantity : "20"
// /// unit : "bags"
// /// image : "https://res.cloudinary.com/yhomi1996/image/upload/v1669963606/y7hkjgmxd0zib9cm7bub.png"
// /// showInShop : false
// /// status : "draft"
// /// createdAt : "2022-12-02T06:46:46.000Z"
// /// updatedAt : "2022-12-02T06:46:46.000Z"
// /// deletedAt : null
// /// category : {"id":"84c25973-1770-4136-ab01-9084e9fddf92","name":"Tiles","description":"Consequat mollit commodo laboris amet est occaecat velit velit proident enim"}
// /// product_image : [{"id":"270b58e2-372b-44f2-b0f7-a0b754df91f7","name":"Screenshot 2022-10-13 at 23.17.38.png","image":"uploads/6EdrE3jScreenshot 2022-10-13 at 23.17.38.png","url":"https://res.cloudinary.com/yhomi1996/image/upload/v1669963606/y7hkjgmxd0zib9cm7bub.png"}]
// ///

MyProducts myProductsFromJson(String str) =>
    MyProducts.fromJson(json.decode(str));
String myProductsToJson(MyProducts data) => json.encode(data.toJson());

// // To parse this JSON data, do
// //
// //     final myProducts = myProductsFromJson(jsonString);

// // To parse this JSON data, do
// //   final myProducts = myProductsFromJson(jsonString);

// class MyProducts {
//     MyProducts({
//         this.id,
//         this.name,
//         this.description,
//         this.categoryId,
//         this.creatorId,
//         this.price,
//         this.quantity,
//         this.weight,
//         this.unit,
//         this.image,
//         this.showInShop,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.creator,
//         this.review,
//         this.category,
//         this.productImage,
//         this.orderTotal,
//         this.inStock,
//         this.remaining,
//     });

//     String? id;
//     String? name;
//     String? description;
//     String? categoryId;
//     String? creatorId;
//     String? price;
//     String? quantity;
//     dynamic weight;
//     String? unit;
//     String? image;
//     bool? showInShop;
//     String? status;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     dynamic deletedAt;
//     Creator? creator;
//     List<dynamic>? review;
//     Category? category;
//     List<ProductImage>? productImage;
//     int? orderTotal;
//     bool? inStock;
//     int? remaining;

//     factory MyProducts.fromRawJson(String str) => MyProducts.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory MyProducts.fromJson(Map<String, dynamic> json) => MyProducts(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         categoryId: json["categoryId"],
//         creatorId: json["creatorId"],
//         price: json["price"],
//         quantity: json["quantity"],
//         weight: json["weight"],
//         unit: json["unit"],
//         image: json["image"],
//         showInShop: json["showInShop"],
//         status: json["status"],
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//         creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
//         review: json["review"] == null ? [] : List<dynamic>.from(json["review"]!.map((x) => x)),
//         category: json["category"] == null ? null : Category.fromJson(json["category"]),
//         productImage: json["product_image"] == null ? [] : List<ProductImage>.from(json["product_image"]!.map((x) => ProductImage.fromJson(x))),
//         orderTotal: json["orderTotal"],
//         inStock: json["in_stock"],
//         remaining: json["remaining"],
//     );

//     static List<MyProducts> fromJsonList(List list) {
//     if (list.isEmpty) return [];
//     return list.map((item) => MyProducts.fromJson(item)).toList();
//   }

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "categoryId": categoryId,
//         "creatorId": creatorId,
//         "price": price,
//         "quantity": quantity,
//         "weight": weight,
//         "unit": unit,
//         "image": image,
//         "showInShop": showInShop,
//         "status": status,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "deletedAt": deletedAt,
//         "creator": creator?.toJson(),
//         "review": review == null ? [] : List<dynamic>.from(review!.map((x) => x)),
//         "category": category?.toJson(),
//         "product_image": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x.toJson())),
//         "orderTotal": orderTotal,
//         "in_stock": inStock,
//         "remaining": remaining,
//     };
// }

// class Category {
//     Category({
//         this.id,
//         this.name,
//         this.description,
//     });

//     String? id;
//     String? name;
//     String? description;

//     factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//     };
// }

// class Creator {
//     Creator({
//         this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.photo,
//     });

//     String? id;
//     String? name;
//     String? email;
//     String? phone;
//     String? photo;

//     factory Creator.fromRawJson(String str) => Creator.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Creator.fromJson(Map<String, dynamic> json) => Creator(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         photo: json["photo"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "photo": photo,
//     };
// }

// class ProductImage {
//     ProductImage({
//         this.id,
//         this.name,
//         this.image,
//         this.url,
//     });

//     String? id;
//     String? name;
//     String? image;
//     String? url;

//     factory ProductImage.fromRawJson(String str) => ProductImage.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
//         id: json["id"],
//         name: json["name"],
//         image: json["image"],
//         url: json["url"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "image": image,
//         "url": url,
//     };
// }

// // class MyProducts {
// //   MyProducts({
// //       String? id,
// //       String? name,
// //       String? description,
// //       String? categoryId,
// //       String? creatorId,
// //       String? price,
// //       String? quantity,
// //       String? unit,
// //       String? image,
// //       bool? showInShop,
// //       String? status,
// //       String? createdAt,
// //       String? updatedAt,
// //       dynamic deletedAt,
// //       Category? category,
// //       List<ProductImage>? productImage,}){
// //     _id = id;
// //     _name = name;
// //     _description = description;
// //     _categoryId = categoryId;
// //     _creatorId = creatorId;
// //     _price = price;
// //     _quantity = quantity;
// //     _unit = unit;
// //     _image = image;
// //     _showInShop = showInShop;
// //     _status = status;
// //     _createdAt = createdAt;
// //     _updatedAt = updatedAt;
// //     _deletedAt = deletedAt;
// //     _category = category;
// //     _productImage = productImage;
// // }

// //   MyProducts.fromJson(dynamic json) {
// //     _id = json['id'];
// //     _name = json['name'];
// //     _description = json['description'];
// //     _categoryId = json['categoryId'];
// //     _creatorId = json['creatorId'];
// //     _price = json['price'];
// //     _quantity = json['quantity'];
// //     _unit = json['unit'];
// //     _image = json['image'];
// //     _showInShop = json['showInShop'];
// //     _status = json['status'];
// //     _createdAt = json['createdAt'];
// //     _updatedAt = json['updatedAt'];
// //     _deletedAt = json['deletedAt'];
// //     _category = json['category'] != null ? Category.fromJson(json['category']) : null;
// //     if (json['product_image'] != null) {
// //       _productImage = [];
// //       json['product_image'].forEach((v) {
// //         _productImage?.add(ProductImage.fromJson(v));
// //       });
// //     }
// //   }
// //   String? _id;
// //   String? _name;
// //   String? _description;
// //   String? _categoryId;
// //   String? _creatorId;
// //   String? _price;
// //   String? _quantity;
// //   String? _unit;
// //   String? _image;
// //   bool? _showInShop;
// //   String? _status;
// //   String? _createdAt;
// //   String? _updatedAt;
// //   dynamic _deletedAt;
// //   Category? _category;
// //   List<ProductImage>? _productImage;
// // MyProducts copyWith({  String? id,
// //   String? name,
// //   String? description,
// //   String? categoryId,
// //   String? creatorId,
// //   String? price,
// //   String? quantity,
// //   String? unit,
// //   String? image,
// //   bool? showInShop,
// //   String? status,
// //   String? createdAt,
// //   String? updatedAt,
// //   dynamic deletedAt,
// //   Category? category,
// //   List<ProductImage>? productImage,
// // }) => MyProducts(  id: id ?? _id,
// //   name: name ?? _name,
// //   description: description ?? _description,
// //   categoryId: categoryId ?? _categoryId,
// //   creatorId: creatorId ?? _creatorId,
// //   price: price ?? _price,
// //   quantity: quantity ?? _quantity,
// //   unit: unit ?? _unit,
// //   image: image ?? _image,
// //   showInShop: showInShop ?? _showInShop,
// //   status: status ?? _status,
// //   createdAt: createdAt ?? _createdAt,
// //   updatedAt: updatedAt ?? _updatedAt,
// //   deletedAt: deletedAt ?? _deletedAt,
// //   category: category ?? _category,
// //   productImage: productImage ?? _productImage,
// // );
// //   String? get id => _id;
// //   String? get name => _name;
// //   String? get description => _description;
// //   String? get categoryId => _categoryId;
// //   String? get creatorId => _creatorId;
// //   String? get price => _price;
// //   String? get quantity => _quantity;
// //   String? get unit => _unit;
// //   String? get image => _image;
// //   bool? get showInShop => _showInShop;
// //   String? get status => _status;
// //   String? get createdAt => _createdAt;
// //   String? get updatedAt => _updatedAt;
// //   dynamic get deletedAt => _deletedAt;
// //   Category? get category => _category;
// //   List<ProductImage>? get productImage => _productImage;

// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['id'] = _id;
// //     map['name'] = _name;
// //     map['description'] = _description;
// //     map['categoryId'] = _categoryId;
// //     map['creatorId'] = _creatorId;
// //     map['price'] = _price;
// //     map['quantity'] = _quantity;
// //     map['unit'] = _unit;
// //     map['image'] = _image;
// //     map['showInShop'] = _showInShop;
// //     map['status'] = _status;
// //     map['createdAt'] = _createdAt;
// //     map['updatedAt'] = _updatedAt;
// //     map['deletedAt'] = _deletedAt;
// //     if (_category != null) {
// //       map['category'] = _category?.toJson();
// //     }
// //     if (_productImage != null) {
// //       map['product_image'] = _productImage?.map((v) => v.toJson()).toList();
// //     }
// //     return map;
// //   }

// //   static List<MyProducts> fromJsonList(List list) {
// //     if (list.isEmpty) return [];
// //     return list.map((item) => MyProducts.fromJson(item)).toList();
// //   }
// // }

// // /// id : "270b58e2-372b-44f2-b0f7-a0b754df91f7"
// // /// name : "Screenshot 2022-10-13 at 23.17.38.png"
// // /// image : "uploads/6EdrE3jScreenshot 2022-10-13 at 23.17.38.png"
// // /// url : "https://res.cloudinary.com/yhomi1996/image/upload/v1669963606/y7hkjgmxd0zib9cm7bub.png"

// // ProductImage productImageFromJson(String str) => ProductImage.fromJson(json.decode(str));
// // String productImageToJson(ProductImage data) => json.encode(data.toJson());
// // class ProductImage {
// //   ProductImage({
// //       String? id,
// //       String? name,
// //       String? image,
// //       String? url,}){
// //     _id = id;
// //     _name = name;
// //     _image = image;
// //     _url = url;
// // }

// //   ProductImage.fromJson(dynamic json) {
// //     _id = json['id'];
// //     _name = json['name'];
// //     _image = json['image'];
// //     _url = json['url'];
// //   }
// //   String? _id;
// //   String? _name;
// //   String? _image;
// //   String? _url;
// // ProductImage copyWith({  String? id,
// //   String? name,
// //   String? image,
// //   String? url,
// // }) => ProductImage(  id: id ?? _id,
// //   name: name ?? _name,
// //   image: image ?? _image,
// //   url: url ?? _url,
// // );
// //   String? get id => _id;
// //   String? get name => _name;
// //   String? get image => _image;
// //   String? get url => _url;

// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['id'] = _id;
// //     map['name'] = _name;
// //     map['image'] = _image;
// //     map['url'] = _url;
// //     return map;
// //   }

// // }

// // /// id : "84c25973-1770-4136-ab01-9084e9fddf92"
// // /// name : "Tiles"
// // /// description : "Consequat mollit commodo laboris amet est occaecat velit velit proident enim"

// // Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
// // String categoryToJson(Category data) => json.encode(data.toJson());
// // class Category {
// //   Category({
// //       String? id,
// //       String? name,
// //       String? description,}){
// //     _id = id;
// //     _name = name;
// //     _description = description;
// // }

// //   Category.fromJson(dynamic json) {
// //     _id = json['id'];
// //     _name = json['name'];
// //     _description = json['description'];
// //   }
// //   String? _id;
// //   String? _name;
// //   String? _description;
// // Category copyWith({  String? id,
// //   String? name,
// //   String? description,
// // }) => Category(  id: id ?? _id,
// //   name: name ?? _name,
// //   description: description ?? _description,
// // );
// //   String? get id => _id;
// //   String? get name => _name;
// //   String? get description => _description;

// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['id'] = _id;
// //     map['name'] = _name;
// //     map['description'] = _description;
// //     return map;
// //   }

// // }

// To parse this JSON data, do
//
//     final myProducts = myProductsFromJson(jsonString);

class MyProducts {
  MyProducts({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.creatorId,
    this.price,
    this.quantity,
    this.weight,
    this.unit,
    this.image,
    this.showInShop,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.creator,
    this.review,
    this.category,
    this.minQty,
    this.maxQty,
    this.productImage,
    this.orderTotal,
    this.inStock,
    this.remaining,
    this.star,
  });

  String? id;
  String? name;
  String? description;
  String? categoryId;
  String? creatorId;
  String? price;
  int? minQty;
  int? maxQty;
  String? quantity;
  dynamic weight;
  String? unit;
  String? image;
  bool? showInShop;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Creator? creator;
  List<Review>? review;
  Category? category;
  List<ProductImage>? productImage;
  int? orderTotal;
  bool? inStock;
  int? remaining;
  double? star;

  factory MyProducts.fromRawJson(String str) =>
      MyProducts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static List<MyProducts> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => MyProducts.fromJson(item)).toList();
  }

  factory MyProducts.fromJson(Map<String, dynamic> json) => MyProducts(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        categoryId: json["categoryId"],
        creatorId: json["creatorId"],
        price: json["price"],
        quantity: json["quantity"],
        weight: json["weight"],
        unit: json["unit"],
        minQty: json["min_qty"],
        maxQty: json["max_qty"],
        image: json["image"],
        showInShop: json["showInShop"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        creator:
            json["creator"] == null ? null : Creator.fromJson(json["creator"]),
        review: json["review"] == null
            ? []
            : List<Review>.from(json["review"]!.map((x) => Review.fromJson(x))),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        productImage: json["product_image"] == null
            ? []
            : List<ProductImage>.from(
                json["product_image"]!.map((x) => ProductImage.fromJson(x))),
        orderTotal: json["orderTotal"],
        inStock: json["in_stock"],
        remaining: json["remaining"],
        star: json["star"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "categoryId": categoryId,
        "creatorId": creatorId,
        "price": price,
        "quantity": quantity,
        "weight": weight,
        "min_qty": minQty,
        "max_qty": maxQty,
        "unit": unit,
        "image": image,
        "showInShop": showInShop,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "creator": creator?.toJson(),
        "review": review == null
            ? []
            : List<dynamic>.from(review!.map((x) => x.toJson())),
        "category": category?.toJson(),
        "product_image": productImage == null
            ? []
            : List<dynamic>.from(productImage!.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "in_stock": inStock,
        "remaining": remaining,
        "star": star,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class Creator {
  Creator({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
  });

  String? id;
  String? name;
  String? email;
  String? phone;
  String? photo;

  factory Creator.fromRawJson(String str) => Creator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "photo": photo,
      };
}

class ProductImage {
  ProductImage({
    this.id,
    this.name,
    this.image,
    this.url,
  });

  String? id;
  String? name;
  String? image;
  String? url;

  factory ProductImage.fromRawJson(String str) =>
      ProductImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "url": url,
      };
}

class Review {
  Review({
    this.id,
    this.userId,
    this.productId,
    this.star,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? userId;
  String? productId;
  int? star;
  String? review;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userId"],
        productId: json["productId"],
        star: json["star"],
        review: json["review"],
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
        "userId": userId,
        "productId": productId,
        "star": star,
        "review": review,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
