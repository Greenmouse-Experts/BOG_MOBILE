// import 'dart:convert';
// /// id : "286fc948-bd0f-47e2-992d-ec7caeef922d"
// /// name : "Green Mouse"
// /// email : "superman4@yopmail.com"
// /// phone : "08116074308"
// /// isActive : true
// /// token : ""
// /// userType : "private_client"
// /// address : ""
// /// state : ""
// /// city : ""
// /// street : ""
// /// level : 1
// /// photo : ""
// /// fname : "Green"
// /// lname : "Mouse"
// /// referralId : "2WDeX9akzXLC"
// /// aboutUs : ""
// /// profile : null
// /// bank_detail : null

// LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));
// String logInModelToJson(LogInModel data) => json.encode(data.toJson());
// class LogInModel {
//   LogInModel({
//       String? id, 
//       String? name, 
//       String? email, 
//       String? phone, 
//       bool? isActive, 
//       String? token, 
//       String? userType, 
//       String? address, 
//       String? state, 
//       String? city, 
//       String? street, 
//       num? level, 
//       String? photo, 
//       String? fname, 
//       String? lname, 
//       String? referralId, 
//       String? aboutUs, 
//       dynamic profile, 
//       dynamic bankDetail,}){
//     _id = id;
//     _name = name;
//     _email = email;
//     _phone = phone;
//     _isActive = isActive;
//     _token = token;
//     _userType = userType;
//     _address = address;
//     _state = state;
//     _city = city;
//     _street = street;
//     _level = level;
//     _photo = photo;
//     _fname = fname;
//     _lname = lname;
//     _referralId = referralId;
//     _aboutUs = aboutUs;
//     _profile = profile;
//     _bankDetail = bankDetail;
// }

//   LogInModel.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _email = json['email'];
//     _phone = json['phone'];
//     _isActive = json['isActive'];
//     _token = json['token'];
//     _userType = json['userType'];
//     _address = json['address'];
//     _state = json['state'];
//     _city = json['city'];
//     _street = json['street'];
//     _level = json['level'];
//     _photo = json['photo'];
//     _fname = json['fname'];
//     _lname = json['lname'];
//     _referralId = json['referralId'];
//     _aboutUs = json['aboutUs'];
//     _profile = json['profile'];
//     _bankDetail = json['bank_detail'];
//   }
//   String? _id;
//   String? _name;
//   String? _email;
//   String? _phone;
//   bool? _isActive;
//   String? _token;
//   String? _userType;
//   String? _address;
//   String? _state;
//   String? _city;
//   String? _street;
//   num? _level;
//   String? _photo;
//   String? _fname;
//   String? _lname;
//   String? _referralId;
//   String? _aboutUs;
//   dynamic _profile;
//   dynamic _bankDetail;
// LogInModel copyWith({  String? id,
//   String? name,
//   String? email,
//   String? phone,
//   bool? isActive,
//   String? token,
//   String? userType,
//   String? address,
//   String? state,
//   String? city,
//   String? street,
//   num? level,
//   String? photo,
//   String? fname,
//   String? lname,
//   String? referralId,
//   String? aboutUs,
//   dynamic profile,
//   dynamic bankDetail,
// }) => LogInModel(  id: id ?? _id,
//   name: name ?? _name,
//   email: email ?? _email,
//   phone: phone ?? _phone,
//   isActive: isActive ?? _isActive,
//   token: token ?? _token,
//   userType: userType ?? _userType,
//   address: address ?? _address,
//   state: state ?? _state,
//   city: city ?? _city,
//   street: street ?? _street,
//   level: level ?? _level,
//   photo: photo ?? _photo,
//   fname: fname ?? _fname,
//   lname: lname ?? _lname,
//   referralId: referralId ?? _referralId,
//   aboutUs: aboutUs ?? _aboutUs,
//   profile: profile ?? _profile,
//   bankDetail: bankDetail ?? _bankDetail,
// );
//   String? get id => _id;
//   String? get name => _name;
//   String? get email => _email;
//   String? get phone => _phone;
//   bool? get isActive => _isActive;
//   String? get token => _token;
//   String? get userType => _userType;
//   String? get address => _address;
//   String? get state => _state;
//   String? get city => _city;
//   String? get street => _street;
//   num? get level => _level;
//   String? get photo => _photo;
//   String? get fname => _fname;
//   String? get lname => _lname;
//   String? get referralId => _referralId;
//   String? get aboutUs => _aboutUs;
//   dynamic get profile => _profile;
//   dynamic get bankDetail => _bankDetail;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['email'] = _email;
//     map['phone'] = _phone;
//     map['isActive'] = _isActive;
//     map['token'] = _token;
//     map['userType'] = _userType;
//     map['address'] = _address;
//     map['state'] = _state;
//     map['city'] = _city;
//     map['street'] = _street;
//     map['level'] = _level;
//     map['photo'] = _photo;
//     map['fname'] = _fname;
//     map['lname'] = _lname;
//     map['referralId'] = _referralId;
//     map['aboutUs'] = _aboutUs;
//     map['profile'] = _profile;
//     map['bank_detail'] = _bankDetail;
//     return map;
//   }

// }

// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

class LogInModel {
    LogInModel({
        this.id,
        this.name,
        this.email,
        this.password,
        this.phone,
        this.isActive,
        this.token,
        this.userType,
        this.address,
        this.state,
        this.city,
        this.street,
        this.level,
        this.photo,
        this.fname,
        this.lname,
        this.referralId,
        this.aboutUs,
        this.isSuspended,
        this.kycScore,
        this.kycTotal,
        this.app,
        this.facebookId,
        this.googleId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.profile,
    });

    String? id;
    String? name;
    String? email;
    String? password;
    String? phone;
    bool? isActive;
    dynamic token;
    String? userType;
    dynamic address;
    dynamic state;
    dynamic city;
    dynamic street;
    int? level;
    String? photo;
    String? fname;
    String? lname;
    String? referralId;
    dynamic aboutUs;
    bool? isSuspended;
    dynamic kycScore;
    dynamic kycTotal;
    dynamic app;
    dynamic facebookId;
    dynamic googleId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    Profile? profile;

    factory LogInModel.fromRawJson(String str) => LogInModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        isActive: json["isActive"],
        token: json["token"],
        userType: json["userType"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        street: json["street"],
        level: json["level"],
        photo: json["photo"],
        fname: json["fname"],
        lname: json["lname"],
        referralId: json["referralId"],
        aboutUs: json["aboutUs"],
        isSuspended: json["isSuspended"],
        kycScore: json["kycScore"],
        kycTotal: json["kycTotal"],
        app: json["app"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "isActive": isActive,
        "token": token,
        "userType": userType,
        "address": address,
        "state": state,
        "city": city,
        "street": street,
        "level": level,
        "photo": photo,
        "fname": fname,
        "lname": lname,
        "referralId": referralId,
        "aboutUs": aboutUs,
        "isSuspended": isSuspended,
        "kycScore": kycScore,
        "kycTotal": kycTotal,
        "app": app,
        "facebook_id": facebookId,
        "google_id": googleId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "profile": profile?.toJson(),
    };
}

class Profile {
    Profile({
        this.id,
        this.userId,
        this.userType,
        this.isVerified,
        this.companyAddress,
        this.companyState,
        this.companyCity,
        this.companyStreet,
        this.companyName,
        this.cacNumber,
        this.tin,
        this.bvn,
        this.yearsOfExperience,
        this.certificateOfOperation,
        this.professionalCertificate,
        this.taxCertificate,
        this.planId,
        this.expiredAt,
        this.hasActiveSubscription,
    });

    String? id;
    String? userId;
    String? userType;
    bool? isVerified;
    dynamic companyAddress;
    dynamic companyState;
    dynamic companyCity;
    dynamic companyStreet;
    String? companyName;
    dynamic cacNumber;
    dynamic tin;
    dynamic bvn;
    dynamic yearsOfExperience;
    dynamic certificateOfOperation;
    dynamic professionalCertificate;
    dynamic taxCertificate;
    dynamic planId;
    dynamic expiredAt;
    bool? hasActiveSubscription;

    factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        userId: json["userId"],
        userType: json["userType"],
        isVerified: json["isVerified"],
        companyAddress: json["company_address"],
        companyState: json["company_state"],
        companyCity: json["company_city"],
        companyStreet: json["company_street"],
        companyName: json["company_name"],
        cacNumber: json["cac_number"],
        tin: json["tin"],
        bvn: json["bvn"],
        yearsOfExperience: json["years_of_experience"],
        certificateOfOperation: json["certificate_of_operation"],
        professionalCertificate: json["professional_certificate"],
        taxCertificate: json["tax_certificate"],
        planId: json["planId"],
        expiredAt: json["expiredAt"],
        hasActiveSubscription: json["hasActiveSubscription"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userType": userType,
        "isVerified": isVerified,
        "company_address": companyAddress,
        "company_state": companyState,
        "company_city": companyCity,
        "company_street": companyStreet,
        "company_name": companyName,
        "cac_number": cacNumber,
        "tin": tin,
        "bvn": bvn,
        "years_of_experience": yearsOfExperience,
        "certificate_of_operation": certificateOfOperation,
        "professional_certificate": professionalCertificate,
        "tax_certificate": taxCertificate,
        "planId": planId,
        "expiredAt": expiredAt,
        "hasActiveSubscription": hasActiveSubscription,
    };
}
