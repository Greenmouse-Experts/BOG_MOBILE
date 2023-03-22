import 'dart:convert';

class FormResponse {
  FormResponse({
    this.form,
  });

  List<FormAnswer>? form;

  factory FormResponse.fromRawJson(String str) =>
      FormResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FormResponse.fromJson(Map<String, dynamic> json) => FormResponse(
        form: json["form"] == null
            ? []
            : List<FormAnswer>.from(
                json["form"]!.map((x) => FormAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "form": form == null
            ? []
            : List<dynamic>.from(form!.map((x) => x.toJson())),
      };
}

class FormAnswer {
  FormAnswer({
    this.id,
    this.value,
  });

  int? id;
  dynamic value;

  factory FormAnswer.fromRawJson(String str) =>
      FormAnswer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FormAnswer.fromJson(Map<String, dynamic> json) => FormAnswer(
        id: json["_id"] ?? 0,
        value: json["value"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? 0,
        "value": value ?? '',
      };
}
