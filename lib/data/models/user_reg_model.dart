// To parse this JSON data, do
//
//     final userRegistration = userRegistrationFromJson(jsonString);

import 'dart:convert';

import 'package:mconnect_app/domain/entities/registration_entities.dart';

UserRegistrationDtos userRegistrationFromJson(String str) =>
    UserRegistrationDtos.fromJson(json.decode(str));

String userRegistrationToJson(UserRegistrationDtos data) =>
    json.encode(data.toJson());

class UserRegistrationDtos extends RegistartionEntities {
  UserRegistrationDtos(
      {String? type,
      int? status,
      int? id,
      String? message,
      List<List<UserRegistrationDtos>>? data,
      String? token,
      String? tokenExpiry})
      : super(
            type: type,
            status: status,
            id: id,
            message: message,
            data: data,
            token: token,
            tokenExpiry: tokenExpiry);

  factory UserRegistrationDtos.fromJson(Map<String, dynamic> json) =>
      UserRegistrationDtos(
        type: json["__type"],
        status: json["Status"],
        id: json["ID"],
        message: json["Message"],
        data: json["DATA"] == null
            ? []
            : List<List<UserRegistrationDtos>>.from(json["DATA"]!.map((x) =>
                List<UserRegistrationDtos>.from(
                    x.map((x) => UserRegistrationDtos.fromJson(x))))),
        token: json["Token"],
        tokenExpiry: json["TokenExpiry"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "Status": status,
        "ID": id,
        "Message": message,
        "DATA": data == null
            ? []
            : List<dynamic>.from(
                data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "Token": token,
        "TokenExpiry": tokenExpiry,
      };
}

// class Datum {
//   String? token;
//   String? tokenExpiry;

//   Datum({
//     this.token,
//     this.tokenExpiry,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         token: json["Token"],
//         tokenExpiry: json["TokenExpiry"],
//       );
//   static List<Datum> fromList(List<dynamic> list) {
//     return list.map((map) => Datum.fromJson(map)).toList();
//   }

//   Map<String, dynamic> toJson() => {
//         "Token": token,
//         "TokenExpiry": tokenExpiry,
//       };
// }
