import 'package:mconnect_app/data/models/refresh_token_model.dart';

class RefreshTokenEntities {
  String? type;
  int? status;
  int? id;
  String? message;
  List<List<RefreshTokenDtos>>? data;
  String? column1;
  String? token;
  String? tokenExpiry;
  RefreshTokenEntities(
      {this.type,
      this.status,
      this.id,
      this.message,
      this.data,
      this.column1,
      this.token,
      this.tokenExpiry});
}
