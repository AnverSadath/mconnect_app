import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mconnect_app/data/datasources/refresh_token_datasources.dart';
import 'package:mconnect_app/data/models/login_pin_bio_model.dart';

import 'package:mconnect_app/data/models/user_login_model.dart';

import 'package:mconnect_app/domain/request/user_login_request.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLoginDataSource {
  Future<UserLoginDtos?> loginUser(UserLoginRequest userLoginRequest);

  Future<LoginPinBioDtos?> loginWithPin();

  Future<LoginPinBioDtos?> loginWithBio();
}

class UserLoginDataSourceImpl extends UserLoginDataSource {
// Loginuser

  Future<UserLoginDtos?> loginUser(UserLoginRequest userLoginRequest) async {
    final url =
        "http://manvish.mnets.in/API/CommanAPIRequest.aspx/ReceiveRequestmCOnnect";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(userLoginRequest.toJson()));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        UserLoginDtos loginDtos = UserLoginDtos.fromJson(responseData['d']);

        if (loginDtos.data != null &&
            loginDtos.data!.isNotEmpty &&
            loginDtos.data![0].isNotEmpty &&
            loginDtos.data![0][0].token != null) {
          String token2 = loginDtos.data![0][0].token!;
          int userId = loginDtos.id ?? 0;

          SharedPreferences prefs2 = await SharedPreferences.getInstance();
          await prefs2.setString("token2", token2);
          await prefs2.setInt("userId", userId);

          print("loginUser Token saved: $token2");
        } else {
          print("loginUser Token not found in response");
        }

        print(responseData);
        return loginDtos;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      return null;
    }
  }

//LoginWithBio

  Future<LoginPinBioDtos?> loginWithBio() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    final token2 = prefs2.getString("token2");
    final userId = prefs2.getInt("userId") ?? 0;

    final url =
        "http://manvish.mnets.in/API/CommanAPIRequest.aspx/ReceiveRequestmCOnnect";

    final requqestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_UserLoginPIN"},
        {"Key": "UserID", "Value": userId},
        {"Key": "Mode", "Value": "BIO"}
      ]
    });

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token2'
          },
          body: requqestBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        LoginPinBioDtos loginPinBioDtos =
            LoginPinBioDtos.fromJson(responseData['d']);

        if (loginPinBioDtos.data != null &&
            loginPinBioDtos.data!.isNotEmpty &&
            loginPinBioDtos.data![0].isNotEmpty &&
            loginPinBioDtos.data![0][0].token != null) {
          String newToken = loginPinBioDtos.data![0][0].token!;
          await prefs2.setString("token2", newToken);

          String tokenExpiry = loginPinBioDtos.data![0][0].tokenExpiry!;

          SharedPreferences prefs3 = await SharedPreferences.getInstance();
          await prefs3.setString("tokenExpiry", tokenExpiry);

          print("loginWithBio New token saved: $newToken");
        }

        print(responseData);
        return loginPinBioDtos;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      return null;
    }
  }

//LoginWithPin

  Future<LoginPinBioDtos?> loginWithPin() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    final token2 = prefs2.getString("token2");
    final userId = prefs2.getInt("userId") ?? 0;

    final url =
        "http://manvish.mnets.in/API/CommanAPIRequest.aspx/ReceiveRequestmCOnnect";

    final requqestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_UserLoginPIN"},
        {"Key": "UserID", "Value": userId},
        {"Key": "Mode", "Value": "BIO"}
      ]
    });

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token2'
          },
          body: requqestBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        LoginPinBioDtos loginPinBioDtos =
            LoginPinBioDtos.fromJson(responseData['d']);

        if (loginPinBioDtos.data != null &&
            loginPinBioDtos.data!.isNotEmpty &&
            loginPinBioDtos.data![0].isNotEmpty &&
            loginPinBioDtos.data![0][0].token != null) {
          String newToken = loginPinBioDtos.data![0][0].token!;
          await prefs2.setString("token2", newToken); // Overwrite the old token

          String tokenExpiry = loginPinBioDtos.data![0][0].tokenExpiry!;
          SharedPreferences prefs3 = await SharedPreferences.getInstance();
          await prefs3.setString("tokenExpiry", tokenExpiry);

          print("loginWithPin New token saved: $newToken");
        } else {
          print("loginWithPin New token not found in response");
        }

        print(responseData);
        return loginPinBioDtos;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      return null;
    }
  }
}
