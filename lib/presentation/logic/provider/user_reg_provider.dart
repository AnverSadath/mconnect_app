import 'package:flutter/material.dart';
import 'package:mconnect_app/data/models/user_activate_model.dart';
import 'package:mconnect_app/data/models/user_reg_model.dart';
import 'package:mconnect_app/domain/repositories/user_reg_repo.dart';

class UserRegistrationProvider extends ChangeNotifier {
  final UserRegistrationRepo userRegistrationRepo;

  UserRegistrationProvider({required this.userRegistrationRepo});

  Future<UserRegistrationDtos?> registeruser(String name, String email,
      String mobile, String designation, String password) async {
    try {
      final response = await userRegistrationRepo.registeruser(
          name, email, mobile, designation, password);
      notifyListeners();
      return response;
    } catch (e) {
      print("Error Registering User:$e");
      throw (e);
    }
  }

  Future<UserActivateDtos?> activateuser(String qrCode) async {
    try {
      final response = await userRegistrationRepo.activateuser(qrCode);
      notifyListeners();
      return response;
    } catch (e) {
      print(" Error Activating User: $e");
      throw (e);
    }
  }
}
