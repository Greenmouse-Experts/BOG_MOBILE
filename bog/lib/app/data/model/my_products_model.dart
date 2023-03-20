// To parse this JSON data, do
//
//     final myProducts = myProductsFromJson(jsonString);

import 'dart:convert';

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
        this.category,
        this.productImage,
    });

    String? id;
    String? name;
    String? description;
    String? categoryId;
    String? creatorId;
    String? price;
    String? quantity;
    dynamic weight;
    String? unit;
    String? image;
    bool? showInShop;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    Category? category;
    List<ProductImage>? productImage;

    factory MyProducts.fromRawJson(String str) => MyProducts.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

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
        image: json["image"],
        showInShop: json["showInShop"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        productImage: json["product_image"] == null ? [] : List<ProductImage>.from(json["product_image"]!.map((x) => ProductImage.fromJson(x))),
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
        "unit": unit,
        "image": image,
        "showInShop": showInShop,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "category": category?.toJson(),
        "product_image": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x.toJson())),
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

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

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

    factory ProductImage.fromRawJson(String str) => ProductImage.fromJson(json.decode(str));

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
