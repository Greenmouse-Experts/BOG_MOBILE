import 'dart:convert';

class FormBuilderModel {
  FormBuilderModel({
    this.formTitle,
    this.serviceType,
    this.formData,
  });

  String? formTitle;
  ServiceType? serviceType;
  List<FormDatum>? formData;

  factory FormBuilderModel.fromRawJson(String str) =>
      FormBuilderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FormBuilderModel.fromJson(Map<String, dynamic> json) =>
      FormBuilderModel(
        formTitle: json["formTitle"],
        serviceType: json["serviceType"] == null
            ? null
            : ServiceType.fromJson(json["serviceType"]),
        formData: json["formData"] == null
            ? []
            : List<FormDatum>.from(
                json["formData"]!.map((x) => FormDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "formTitle": formTitle,
        "serviceType": serviceType?.toJson(),
        "formData": formData == null
            ? []
            : List<dynamic>.from(formData!.map((x) => x.toJson())),
      };
}

class FormDatum {
  FormDatum({
    this.id,
    this.label,
    this.name,
    this.inputType,
    this.required,
    this.placeholder,
    this.multiple,
    this.requireValidOption,
    this.className,
    this.toggle,
    this.subtype,
    this.values,
  });

  int? id;
  String? label;
  String? name;
  String? inputType;
  dynamic required;
  dynamic placeholder;
  dynamic multiple;
  dynamic requireValidOption;
  String? className;
  dynamic toggle;
  String? subtype;
  List<Value>? values;

  factory FormDatum.fromRawJson(String str) =>
      FormDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FormDatum.fromJson(Map<String, dynamic> json) => FormDatum(
        id: json["id"],
        label: json["label"],
        name: json["name"],
        inputType: json["inputType"],
        required: json["required"],
        placeholder: json["placeholder"],
        multiple: json["multiple"],
        requireValidOption: json["requireValidOption"],
        className: json["className"],
        toggle: json["toggle"],
        subtype: json["subtype"],
        values: json["_values"] == null
            ? []
            : List<Value>.from(json["_values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "name": name,
        "inputType": inputType,
        "required": required,
        "placeholder": placeholder,
        "multiple": multiple,
        "requireValidOption": requireValidOption,
        "className": className,
        "toggle": toggle,
        "subtype": subtype,
        "_values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class Value {
  Value({
    this.id,
    this.label,
    this.selected,
    this.value,
    this.isActive,
  });

  int? id;
  String? label;
  bool? selected;
  String? value;
  bool? isActive;

  factory Value.fromRawJson(String str) => Value.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        label: json["label"],
        selected: json["selected"],
        value: json["value"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "selected": selected,
        "value": value,
        "isActive": isActive,
      };
}

class ServiceType {
  ServiceType({
    this.id,
    this.title,
    this.serviceId,
    this.description,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? title;
  String? serviceId;
  String? description;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory ServiceType.fromRawJson(String str) =>
      ServiceType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
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
      };
}
