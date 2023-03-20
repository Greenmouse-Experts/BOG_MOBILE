import 'dart:convert';

class GetServices {
  GetServices({
    this.id,
    this.title,
    this.serviceId,
    this.description,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.serviceDetail,
  });

  String? id;
  String? title;
  dynamic serviceId;
  String? description;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  ServiceDetail? serviceDetail;

  factory GetServices.fromRawJson(String str) =>
      GetServices.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetServices.fromJson(Map<String, dynamic> json) => GetServices(
        id: json["id"],
        title: json["title"],
        serviceId: json["serviceId"],
        description: json["description"],
        slug: json["slug"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        serviceDetail: json["service"] == null
            ? null
            : ServiceDetail.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "serviceId": serviceId,
        "description": description,
        "slug": slug,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "service": serviceDetail?.toJson(),
      };
}

class ServiceDetail {
  ServiceDetail({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? name;
  String? slug;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory ServiceDetail.fromRawJson(String str) =>
      ServiceDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
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
        "name": name,
        "slug": slug,
        "icon": icon,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
