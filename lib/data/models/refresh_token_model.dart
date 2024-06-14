import 'dart:convert';

import 'package:mconnect_app/domain/entities/refresh_token_entities.dart';

RefreshTokenDtos tokenRefreshFromJson(String str) =>
    RefreshTokenDtos.fromJson(json.decode(str));

String tokenRefreshToJson(RefreshTokenDtos data) => json.encode(data.toJson());

class RefreshTokenDtos extends RefreshTokenEntities {
  RefreshTokenDtos(
      {String? type,
      int? status,
      int? id,
      String? message,
      List<List<RefreshTokenDtos>>? data,
      String? column1,
      String? token,
      String? tokenExpiry})
      : super(
            type: type,
            status: status,
            id: id,
            message: message,
            data: data,
            column1: column1,
            token: token,
            tokenExpiry: tokenExpiry);

  factory RefreshTokenDtos.fromJson(Map<String, dynamic> json) =>
      RefreshTokenDtos(
        type: json["__type"],
        status: json["Status"],
        id: json["ID"],
        message: json["Message"],
        data: json["DATA"] == null
            ? []
            : List<List<RefreshTokenDtos>>.from(json["DATA"]!.map((x) =>
                List<RefreshTokenDtos>.from(
                    x.map((x) => RefreshTokenDtos.fromJson(x))))),
        column1: json["Column1"],
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
        "Column1": column1,
        "Token": token,
        "TokenExpiry": tokenExpiry,
      };
}

// class Datum {
//   String? column1;
//   String? token;
//   String? tokenExpiry;

//   Datum({
//     this.column1,
//     this.token,
//     this.tokenExpiry,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         column1: json["Column1"],
//         token: json["Token"],
//         tokenExpiry: json["TokenExpiry"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Column1": column1,
//         "Token": token,
//         "TokenExpiry": tokenExpiry,
//       };
// }
