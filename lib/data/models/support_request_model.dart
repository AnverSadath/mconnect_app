// To parse this JSON data, do
//
//     final supportDtos = supportDtosFromJson(jsonString);

import 'dart:convert';

SupportRequestDtos supportDtosFromJson(String str) =>
    SupportRequestDtos.fromJson(json.decode(str));

String supportDtosToJson(SupportRequestDtos data) => json.encode(data.toJson());

class SupportRequestDtos {
  String? type;
  int? status;
  int? id;
  String? message;
  dynamic data;

  SupportRequestDtos({
    this.type,
    this.status,
    this.id,
    this.message,
    this.data,
  });

  factory SupportRequestDtos.fromJson(Map<String, dynamic> json) =>
      SupportRequestDtos(
        type: json["__type"],
        status: json["Status"],
        id: json["ID"],
        message: json["Message"],
        data: json["DATA"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "Status": status,
        "ID": id,
        "Message": message,
        "DATA": data,
      };
}
