// To parse this JSON data, do
//
//     final onsiteRquestDtos = onsiteRquestDtosFromJson(jsonString);

import 'dart:convert';

OnsiteRequestDtos onsiteRquestDtosFromJson(String str) =>
    OnsiteRequestDtos.fromJson(json.decode(str));

String onsiteRquestDtosToJson(OnsiteRequestDtos data) =>
    json.encode(data.toJson());

class OnsiteRequestDtos {
  String? type;
  int? status;
  int? id;
  String? message;
  dynamic data;

  OnsiteRequestDtos({
    this.type,
    this.status,
    this.id,
    this.message,
    this.data,
  });

  factory OnsiteRequestDtos.fromJson(Map<String, dynamic> json) =>
      OnsiteRequestDtos(
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
