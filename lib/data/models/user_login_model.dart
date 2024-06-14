// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

import 'package:mconnect_app/domain/entities/login_entities.dart';

UserLoginDtos userLoginFromJson(String str) =>
    UserLoginDtos.fromJson(json.decode(str));

String userLoginToJson(UserLoginDtos data) => json.encode(data.toJson());

class UserLoginDtos extends LoginEntities {
  UserLoginDtos(
      {String? type,
      int? status,
      int? id,
      String? message,
      List<List<UserLoginDtos>>? data,
      String? name,
      String? mobile,
      String? email,
      String? designation,
      int? custId,
      String? token,
      String? tokenExpiry,
      String? serialNo,
      String? companyName,
      String? column1})
      : super(
            type: type,
            status: status,
            id: id,
            message: message,
            data: data,
            name: name,
            mobile: mobile,
            email: email,
            designation: designation,
            custId: custId,
            token: token,
            tokenExpiry: tokenExpiry,
            serialNo: serialNo,
            companyName: companyName,
            column1: column1);

  factory UserLoginDtos.fromJson(Map<String, dynamic> json) => UserLoginDtos(
        type: json["__type"],
        status: json["Status"],
        id: json["ID"],
        message: json["Message"],
        data: json["DATA"] == null
            ? []
            : List<List<UserLoginDtos>>.from(json["DATA"]!.map((x) =>
                List<UserLoginDtos>.from(
                    x.map((x) => UserLoginDtos.fromJson(x))))),
        name: json["Name"],
        mobile: json["Mobile"],
        email: json["Email"],
        designation: json["Designation"],
        custId: json["CustID"],
        token: json["Token"],
        tokenExpiry: json["TokenExpiry"],
        serialNo: json["SerialNo"],
        companyName: json["CompanyName"],
        column1: json["Column1"],
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
        "Name": name,
        "Mobile": mobile,
        "Email": email,
        "Designation": designation,
        "CustID": custId,
        "Token": token,
        "TokenExpiry": tokenExpiry,
        "SerialNo": serialNo,
        "CompanyName": companyName,
        "Column1": column1,
      };
}

// class Datum {
//   String? name;
//   String? mobile;
//   String? email;
//   String? designation;
//   int? custId;
//   String? token;
//   String? tokenExpiry;
//   String? serialNo;
//   String? companyName;
//   String? column1;

//   Datum({
//     this.name,
//     this.mobile,
//     this.email,
//     this.designation,
//     this.custId,
//     this.token,
//     this.tokenExpiry,
//     this.serialNo,
//     this.companyName,
//     this.column1,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         name: json["Name"],
//         mobile: json["Mobile"],
//         email: json["Email"],
//         designation: json["Designation"],
//         custId: json["CustID"],
//         token: json["Token"],
//         tokenExpiry: json["TokenExpiry"],
//         serialNo: json["SerialNo"],
//         companyName: json["CompanyName"],
//         column1: json["Column1"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Name": name,
//         "Mobile": mobile,
//         "Email": email,
//         "Designation": designation,
//         "CustID": custId,
//         "Token": token,
//         "TokenExpiry": tokenExpiry,
//         "SerialNo": serialNo,
//         "CompanyName": companyName,
//         "Column1": column1,
//       };
// }
