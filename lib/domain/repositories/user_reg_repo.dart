import 'package:mconnect_app/data/models/user_activate_model.dart';
import 'package:mconnect_app/data/models/user_reg_model.dart';

abstract class UserRegistrationRepo {
  Future<UserRegistrationDtos?> registeruser(String name, String email,
      String mobile, String designation, String password);

  Future<UserActivateDtos?> activateuser(String qrCode);
}
