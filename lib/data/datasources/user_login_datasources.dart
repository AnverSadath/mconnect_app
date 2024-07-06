import 'dart:convert';
import 'package:mconnect_app/core/constants/url.dart';
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/data/datasources/api_http_client.dart';
import 'package:mconnect_app/data/datasources/local_storage.dart';
import 'package:mconnect_app/data/models/login_pin_bio_model.dart';
import 'package:mconnect_app/data/models/user_login_model.dart';
import 'package:mconnect_app/domain/request/user_login_request.dart';

abstract class UserLoginDataSource {
  Future<UserLoginDtos?> loginUser(UserLoginRequest userLoginRequest);

  Future<LoginPinBioDtos?> loginWithPin();

  Future<LoginPinBioDtos?> loginWithBio();
}

class UserLoginDataSourceImpl extends ApiClient implements UserLoginDataSource {
  final SharedPreferencesService prefsService = sl<SharedPreferencesService>();
  UserLoginDataSourceImpl({required super.client});
// Loginuser

  Future<UserLoginDtos?> loginUser(UserLoginRequest userLoginRequest) async {
    final url = Url.baseUrl;
    try {
      final response = await client.post(Uri.parse(url),
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
          String tokenExpiry = loginDtos.data![0][0].tokenExpiry!;

          await prefsService.setToken(token2);
          await prefsService.setUserId(userId);
          await prefsService.setTokenExpiry(tokenExpiry);

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
    final token2 = await prefsService.getToken();
    final userId = await prefsService.getUserId();
    // final tokenexpiry = await prefsService.getTokenExpiry();

    final url = Url.baseUrl;

    final requestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_UserLoginPIN"},
        {"Key": "UserID", "Value": userId},
        {"Key": "Mode", "Value": "BIO"}
      ]
    });

    try {
      final response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token2'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        LoginPinBioDtos loginPinBioDtos =
            LoginPinBioDtos.fromJson(responseData['d']);

        if (loginPinBioDtos.data != null &&
            loginPinBioDtos.data!.isNotEmpty &&
            loginPinBioDtos.data![0].isNotEmpty &&
            loginPinBioDtos.data![0][0].token != null) {
          String newToken = loginPinBioDtos.data![0][0].token!;
          String tokenExpirydate = loginPinBioDtos.data![0][0].tokenExpiry!;

          await prefsService.setToken(newToken);
          await prefsService.setTokenExpiry(tokenExpirydate);

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
    final token2 = await prefsService.getToken();
    final userId = await prefsService.getUserId();
    //  final tokenexpiry = await prefsService.getTokenExpiry();

    final url = Url.baseUrl;

    final requestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_UserLoginPIN"},
        {"Key": "UserID", "Value": userId},
        {"Key": "Mode", "Value": "PIN"}
      ]
    });

    try {
      final response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token2'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        LoginPinBioDtos loginPinBioDtos =
            LoginPinBioDtos.fromJson(responseData['d']);

        if (loginPinBioDtos.data != null &&
            loginPinBioDtos.data!.isNotEmpty &&
            loginPinBioDtos.data![0].isNotEmpty &&
            loginPinBioDtos.data![0][0].token != null) {
          String newToken = loginPinBioDtos.data![0][0].token!;
          String tokenExpirydate = loginPinBioDtos.data![0][0].tokenExpiry!;

          await prefsService.setToken(newToken); // Overwrite the old token
          await prefsService.setTokenExpiry(tokenExpirydate);

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
