// To parse this JSON data, do
//
//     final userActivate = userActivateFromJson(jsonString);

import 'dart:convert';

import 'package:mconnect_app/domain/entities/activate_entities.dart';

UserActivateDtos userActivateFromJson(String str) =>
    UserActivateDtos.fromJson(json.decode(str));

String userActivateToJson(UserActivateDtos data) => json.encode(data.toJson());

class UserActivateDtos extends ActivateEntities {
  UserActivateDtos(
      {String? type, int? status, int? id, String? message, dynamic data})
      : super(type: type, status: status, id: id, message: message, data: data);

  factory UserActivateDtos.fromJson(Map<String, dynamic> json) =>
      UserActivateDtos(
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
