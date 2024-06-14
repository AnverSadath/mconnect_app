import 'package:flutter/material.dart';
import 'package:mconnect_app/data/models/refresh_token_model.dart';
import 'package:mconnect_app/domain/repositories/refresh_token_repo.dart';

class TokenRefreshProvider extends ChangeNotifier {
  TokenRefreshRepo tokenRefreshRepo;

  TokenRefreshProvider({required this.tokenRefreshRepo});

  Future<RefreshTokenDtos?> tokenRefresh() async {
    try {
      final response = await tokenRefreshRepo.tokenRefresh();
      notifyListeners();
      return response;
    } catch (e) {
      print("Error Loging User$e");
      throw (e);
    }
  }
}
