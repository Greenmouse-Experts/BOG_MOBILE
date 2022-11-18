import 'dart:convert';
/// id : 302
/// name : "9mobile 9Payment Service Bank"
/// slug : "9mobile-9payment-service-bank-ng"
/// code : "120001"
/// longcode : "120001"
/// gateway : ""
/// pay_with_bank : false
/// active : true
/// country : "Nigeria"
/// currency : "NGN"
/// type : "nuban"
/// is_deleted : false
/// createdAt : "2022-05-31T06:50:27.000Z"
/// updatedAt : "2022-06-23T09:33:55.000Z"

BankListModel bankListModelFromJson(String str) => BankListModel.fromJson(json.decode(str));
String bankListModelToJson(BankListModel data) => json.encode(data.toJson());
class BankListModel {
  BankListModel({
      num? id, 
      String? name, 
      String? slug, 
      String? code, 
      String? longcode, 
      String? gateway, 
      bool? payWithBank, 
      bool? active, 
      String? country, 
      String? currency, 
      String? type, 
      bool? isDeleted, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _slug = slug;
    _code = code;
    _longcode = longcode;
    _gateway = gateway;
    _payWithBank = payWithBank;
    _active = active;
    _country = country;
    _currency = currency;
    _type = type;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  BankListModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _code = json['code'];
    _longcode = json['longcode'];
    _gateway = json['gateway'];
    _payWithBank = json['pay_with_bank'];
    _active = json['active'];
    _country = json['country'];
    _currency = json['currency'];
    _type = json['type'];
    _isDeleted = json['is_deleted'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  num? _id;
  String? _name;
  String? _slug;
  String? _code;
  String? _longcode;
  String? _gateway;
  bool? _payWithBank;
  bool? _active;
  String? _country;
  String? _currency;
  String? _type;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
BankListModel copyWith({  num? id,
  String? name,
  String? slug,
  String? code,
  String? longcode,
  String? gateway,
  bool? payWithBank,
  bool? active,
  String? country,
  String? currency,
  String? type,
  bool? isDeleted,
  String? createdAt,
  String? updatedAt,
}) => BankListModel(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  code: code ?? _code,
  longcode: longcode ?? _longcode,
  gateway: gateway ?? _gateway,
  payWithBank: payWithBank ?? _payWithBank,
  active: active ?? _active,
  country: country ?? _country,
  currency: currency ?? _currency,
  type: type ?? _type,
  isDeleted: isDeleted ?? _isDeleted,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get code => _code;
  String? get longcode => _longcode;
  String? get gateway => _gateway;
  bool? get payWithBank => _payWithBank;
  bool? get active => _active;
  String? get country => _country;
  String? get currency => _currency;
  String? get type => _type;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['code'] = _code;
    map['longcode'] = _longcode;
    map['gateway'] = _gateway;
    map['pay_with_bank'] = _payWithBank;
    map['active'] = _active;
    map['country'] = _country;
    map['currency'] = _currency;
    map['type'] = _type;
    map['is_deleted'] = _isDeleted;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

  static List<BankListModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => BankListModel.fromJson(item)).toList();
  }
}