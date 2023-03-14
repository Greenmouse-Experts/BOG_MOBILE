// // To parse this JSON data, do
// //
// //     final getServices = getServicesFromJson(jsonString);

// import 'dart:convert';

// class GetServices {
//   GetServices({
//     required this.id,
//     required this.name,
//     this.slug,
//     this.icon,
//     required this.createdAt,
//     required this.updatedAt,
//     this.deletedAt,
//   });

//   final String id;
//   final String name;
//   final String? slug;
//   final String? icon;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final dynamic deletedAt;

//   factory GetServices.fromRawJson(String str) =>
//       GetServices.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory GetServices.fromJson(Map<String, dynamic> json) => GetServices(
//         id: json["id"],
//         name: json["name"],
//         slug: json["slug"],
//         icon: json["icon"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "slug": slug,
//         "icon": icon,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "deletedAt": deletedAt,
//       };
// }

// To parse this JSON data, do
//
//     final getService = getServiceFromJson(jsonString);

import 'dart:convert';

class GetServices {
  GetServices({
    required this.id,
    required this.title,
    required this.serviceId,
    required this.description,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.service,
  });

  final String id;
  final String title;
  final String serviceId;
  final String description;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final Service service;

  factory GetServices.fromRawJson(String str) =>
      GetServices.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetServices.fromJson(Map<String, dynamic> json) => GetServices(
        id: json["id"],
        title: json["title"],
        serviceId: json["serviceId"],
        description: json["description"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        service: Service.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "serviceId": serviceId,
        "description": description,
        "slug": slug,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "service": service.toJson(),
      };
}

class Service {
  Service({
    required this.id,
    required this.name,
    this.slug,
    this.icon,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String name;
  final String? slug;
  final String? icon;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        icon: json["icon"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "icon": icon,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
