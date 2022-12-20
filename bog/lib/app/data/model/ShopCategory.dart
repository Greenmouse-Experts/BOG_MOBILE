import 'dart:convert';
/// id : "42e9e3c9-e4d7-4af8-8041-68cc2b0bb42c"
/// name : "Ramadan"
/// description : "Ram ram ramoski Ayinde keke Alhaji Ramadan Fawaz Olamilekan Timileyin"
/// totalProducts : 0

ShopCategory shopCategoryFromJson(String str) => ShopCategory.fromJson(json.decode(str));
String shopCategoryToJson(ShopCategory data) => json.encode(data.toJson());
class ShopCategory {
  ShopCategory({
      String? id, 
      String? name, 
      String? description, 
      num? totalProducts,}){
    _id = id;
    _name = name;
    _description = description;
    _totalProducts = totalProducts;
}

  ShopCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _totalProducts = json['totalProducts'];
  }
  String? _id;
  String? _name;
  String? _description;
  num? _totalProducts;
ShopCategory copyWith({  String? id,
  String? name,
  String? description,
  num? totalProducts,
}) => ShopCategory(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  totalProducts: totalProducts ?? _totalProducts,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get totalProducts => _totalProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['totalProducts'] = _totalProducts;
    return map;
  }

  static List<ShopCategory> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => ShopCategory.fromJson(item)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopCategory &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _name == other._name &&
          _description == other._description;

  @override
  int get hashCode => _id.hashCode ^ _name.hashCode ^ _description.hashCode;
}