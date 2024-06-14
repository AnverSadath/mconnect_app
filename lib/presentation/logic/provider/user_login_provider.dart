import 'package:flutter/material.dart';
import 'package:mconnect_app/data/models/login_pin_bio_model.dart';
import 'package:mconnect_app/data/models/user_login_model.dart';
import 'package:mconnect_app/domain/repositories/user_login_repo.dart';

class UserLoginProvider extends ChangeNotifier {
  final UserLoginRepo userLoginRepo;

  UserLoginProvider({required this.userLoginRepo});

  Future<UserLoginDtos?> loginuser(String name, String password) async {
    try {
      final response = await userLoginRepo.loginuser(name, password);
      notifyListeners();
      return response;
    } catch (e) {
      print("Error Loging User$e");
      throw (e);
    }
  }

  Future<LoginPinBioDtos?> loginWithBio() async {
    try {
      final response = await userLoginRepo.loginWithBio();
      notifyListeners();
      return response;
    } catch (e) {
      print("Error BioLoging User$e");
      throw (e);
    }
  }

  Future<LoginPinBioDtos?> loginWithPin() async {
    try {
      final response = await userLoginRepo.loginWithPin();
      notifyListeners();
      return response;
    } catch (e) {
      print("Error BioLoging User$e");
      throw (e);
    }
  }
}
