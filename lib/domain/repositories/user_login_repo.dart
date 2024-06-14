import 'package:mconnect_app/data/models/login_pin_bio_model.dart';
import 'package:mconnect_app/data/models/user_login_model.dart';

abstract class UserLoginRepo {
  Future<UserLoginDtos?> loginuser(String name, String password);
  Future<LoginPinBioDtos?> loginWithBio();
  Future<LoginPinBioDtos?> loginWithPin();
}
