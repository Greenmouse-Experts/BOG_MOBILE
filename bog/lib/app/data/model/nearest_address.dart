// To parse this JSON data, do
//
//     final nearestAddress = nearestAddressFromJson(jsonString);

import 'dart:convert';

class NearestAddress {
  NearestAddress({
    this.id,
    this.title,
    this.address,
    this.state,
    this.country,
    this.longitude,
    this.latitude,
    this.zipcode,
    this.charge,
    this.deliveryType,
    this.deliveryTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.insurancecharge,
  });

  String? id;
  String? title;
  String? address;
  String? state;
  String? country;
  dynamic longitude;
  dynamic latitude;
  String? zipcode;
  int? charge;
  dynamic deliveryType;
  String? deliveryTime;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic insurancecharge;

  factory NearestAddress.fromRawJson(String str) =>
      NearestAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NearestAddress.fromJson(Map<String, dynamic> json) => NearestAddress(
        id: json["id"],
        title: json["title"],
        address: json["address"],
        state: json["state"],
        country: json["country"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        zipcode: json["zipcode"],
        charge: json["charge"],
        deliveryType: json["delivery_type"],
        deliveryTime: json["delivery_time"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        insurancecharge: json["insurancecharge"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "address": address,
        "state": state,
        "country": country,
        "longitude": longitude,
        "latitude": latitude,
        "zipcode": zipcode,
        "charge": charge,
        "delivery_type": deliveryType,
        "delivery_time": deliveryTime,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "insurancecharge" : insurancecharge
      };
}
