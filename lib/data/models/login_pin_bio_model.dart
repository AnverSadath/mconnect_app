// To parse this JSON data, do
//
//     final userLoginPin = userLoginPinFromJson(jsonString);

import 'dart:convert';

LoginPinBioDtos userLoginPinFromJson(String str) =>
    LoginPinBioDtos.fromJson(json.decode(str));

String userLoginPinToJson(LoginPinBioDtos data) => json.encode(data.toJson());

class LoginPinBioDtos {
  String? type;
  int? status;
  int? id;
  String? message;
  List<List<Datum>>? data;

  LoginPinBioDtos({
    this.type,
    this.status,
    this.id,
    this.message,
    this.data,
  });

  factory LoginPinBioDtos.fromJson(Map<String, dynamic> json) =>
      LoginPinBioDtos(
        type: json["__type"],
        status: json["Status"],
        id: json["ID"],
        message: json["Message"],
        data: json["DATA"] == null
            ? []
            : List<List<Datum>>.from(json["DATA"]!
                .map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
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
      };
}

class Datum {
  String? name;
  String? mobile;
  String? email;
  String? designation;
  int? custId;
  String? token;
  String? tokenExpiry;
  String? serialNo;
  String? companyName;
  String? mConnectType;

  Datum({
    this.name,
    this.mobile,
    this.email,
    this.designation,
    this.custId,
    this.token,
    this.tokenExpiry,
    this.serialNo,
    this.companyName,
    this.mConnectType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["Name"],
        mobile: json["Mobile"],
        email: json["Email"],
        designation: json["Designation"],
        custId: json["CustID"],
        token: json["Token"],
        tokenExpiry: json["TokenExpiry"],
        serialNo: json["SerialNo"],
        companyName: json["CompanyName"],
        mConnectType: json["mConnectType"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Mobile": mobile,
        "Email": email,
        "Designation": designation,
        "CustID": custId,
        "Token": token,
        "TokenExpiry": tokenExpiry,
        "SerialNo": serialNo,
        "CompanyName": companyName,
        "mConnectType": mConnectType,
      };
}
