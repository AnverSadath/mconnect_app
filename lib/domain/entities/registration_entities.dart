import 'package:mconnect_app/data/models/user_reg_model.dart';

class RegistartionEntities {
  String? type;
  int? status;
  int? id;
  String? message;
  List<List<UserRegistrationDtos>>? data;
  String? token;
  String? tokenExpiry;

  RegistartionEntities(
      {this.type,
      this.status,
      this.id,
      this.message,
      this.data,
      this.token,
      this.tokenExpiry});
}
