import 'dart:convert';
/// id : "286fc948-bd0f-47e2-992d-ec7caeef922d"
/// name : "Green Mouse"
/// email : "superman4@yopmail.com"
/// phone : "08116074308"
/// isActive : true
/// token : ""
/// userType : "private_client"
/// address : ""
/// state : ""
/// city : ""
/// street : ""
/// level : 1
/// photo : ""
/// fname : "Green"
/// lname : "Mouse"
/// referralId : "2WDeX9akzXLC"
/// aboutUs : ""
/// profile : null
/// bank_detail : null

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));
String logInModelToJson(LogInModel data) => json.encode(data.toJson());
class LogInModel {
  LogInModel({
      String? id, 
      String? name, 
      String? email, 
      String? phone, 
      bool? isActive, 
      String? token, 
      String? userType, 
      String? address, 
      String? state, 
      String? city, 
      String? street, 
      num? level, 
      String? photo, 
      String? fname, 
      String? lname, 
      String? referralId, 
      String? aboutUs, 
      dynamic profile, 
      dynamic bankDetail,}){
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _isActive = isActive;
    _token = token;
    _userType = userType;
    _address = address;
    _state = state;
    _city = city;
    _street = street;
    _level = level;
    _photo = photo;
    _fname = fname;
    _lname = lname;
    _referralId = referralId;
    _aboutUs = aboutUs;
    _profile = profile;
    _bankDetail = bankDetail;
}

  LogInModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _isActive = json['isActive'];
    _token = json['token'];
    _userType = json['userType'];
    _address = json['address'];
    _state = json['state'];
    _city = json['city'];
    _street = json['street'];
    _level = json['level'];
    _photo = json['photo'];
    _fname = json['fname'];
    _lname = json['lname'];
    _referralId = json['referralId'];
    _aboutUs = json['aboutUs'];
    _profile = json['profile'];
    _bankDetail = json['bank_detail'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  bool? _isActive;
  String? _token;
  String? _userType;
  String? _address;
  String? _state;
  String? _city;
  String? _street;
  num? _level;
  String? _photo;
  String? _fname;
  String? _lname;
  String? _referralId;
  String? _aboutUs;
  dynamic _profile;
  dynamic _bankDetail;
LogInModel copyWith({  String? id,
  String? name,
  String? email,
  String? phone,
  bool? isActive,
  String? token,
  String? userType,
  String? address,
  String? state,
  String? city,
  String? street,
  num? level,
  String? photo,
  String? fname,
  String? lname,
  String? referralId,
  String? aboutUs,
  dynamic profile,
  dynamic bankDetail,
}) => LogInModel(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  phone: phone ?? _phone,
  isActive: isActive ?? _isActive,
  token: token ?? _token,
  userType: userType ?? _userType,
  address: address ?? _address,
  state: state ?? _state,
  city: city ?? _city,
  street: street ?? _street,
  level: level ?? _level,
  photo: photo ?? _photo,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  referralId: referralId ?? _referralId,
  aboutUs: aboutUs ?? _aboutUs,
  profile: profile ?? _profile,
  bankDetail: bankDetail ?? _bankDetail,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  bool? get isActive => _isActive;
  String? get token => _token;
  String? get userType => _userType;
  String? get address => _address;
  String? get state => _state;
  String? get city => _city;
  String? get street => _street;
  num? get level => _level;
  String? get photo => _photo;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get referralId => _referralId;
  String? get aboutUs => _aboutUs;
  dynamic get profile => _profile;
  dynamic get bankDetail => _bankDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['isActive'] = _isActive;
    map['token'] = _token;
    map['userType'] = _userType;
    map['address'] = _address;
    map['state'] = _state;
    map['city'] = _city;
    map['street'] = _street;
    map['level'] = _level;
    map['photo'] = _photo;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['referralId'] = _referralId;
    map['aboutUs'] = _aboutUs;
    map['profile'] = _profile;
    map['bank_detail'] = _bankDetail;
    return map;
  }

}