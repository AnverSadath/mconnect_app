import 'package:mconnect_app/data/models/user_login_model.dart';

class LoginEntities {
  String? type;
  int? status;
  int? id;
  String? message;
  List<List<UserLoginDtos>>? data;
  String? name;
  String? mobile;
  String? email;
  String? designation;
  int? custId;
  String? token;
  String? tokenExpiry;
  String? serialNo;
  String? companyName;
  String? column1;

  LoginEntities({
    this.type,
    this.status,
    this.id,
    this.message,
    this.data,
    this.name,
    this.mobile,
    this.email,
    this.designation,
    this.custId,
    this.token,
    this.tokenExpiry,
    this.serialNo,
    this.companyName,
    this.column1,
  });
}
