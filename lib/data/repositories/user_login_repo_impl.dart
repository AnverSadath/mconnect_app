import 'package:mconnect_app/data/datasources/user_login_datasources.dart';
import 'package:mconnect_app/data/models/login_pin_bio_model.dart';
import 'package:mconnect_app/data/models/user_login_model.dart';
import 'package:mconnect_app/domain/repositories/user_login_repo.dart';
import 'package:mconnect_app/domain/request/user_login_request.dart';

class UserLoginRepoImpl implements UserLoginRepo {
  UserLoginDataSource userLoginDataSource;

  UserLoginRepoImpl({required this.userLoginDataSource});
  @override
  Future<UserLoginDtos?> loginuser(String name, String password) async {
    try {
      return await userLoginDataSource
          .loginUser(UserLoginRequest(name: name, password: password));
    } catch (e) {
      print(" error loging user:$e");
      throw (e);
    }
  }

  Future<LoginPinBioDtos?> loginWithBio() async {
    try {
      return await userLoginDataSource.loginWithBio();
    } catch (e) {
      print(" error biologing user:$e");
      throw (e);
    }
  }

  Future<LoginPinBioDtos?> loginWithPin() async {
    try {
      return await userLoginDataSource.loginWithPin();
    } catch (e) {
      print(" error biologing user:$e");
      throw (e);
    }
  }
}
