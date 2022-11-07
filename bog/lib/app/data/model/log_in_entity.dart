import 'package:null/generated/json/base/json_field.dart';
import 'package:null/generated/json/log_in_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class LogInEntity {

	String? id;
	String? name;
	String? email;
	String? phone;
	bool? isActive;
	dynamic token;
	String? userType;
	dynamic address;
	dynamic state;
	dynamic city;
	dynamic street;
	int? level;
	dynamic photo;
	String? fname;
	String? lname;
	String? referralId;
	dynamic aboutUs;
	dynamic profile;
	@JSONField(name: "bank_detail")
	dynamic bankDetail;
  
  LogInEntity();

  factory LogInEntity.fromJson(Map<String, dynamic> json) => $LogInEntityFromJson(json);

  Map<String, dynamic> toJson() => $LogInEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}