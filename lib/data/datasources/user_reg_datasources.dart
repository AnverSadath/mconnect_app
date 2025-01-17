import 'dart:convert';
import 'package:mconnect_app/core/constants/url.dart';
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/data/datasources/api_http_client.dart';
import 'package:mconnect_app/data/datasources/local_storage.dart';
import 'package:mconnect_app/domain/request/user_reg_request.dart';
import 'package:mconnect_app/data/models/user_activate_model.dart';
import 'package:mconnect_app/data/models/user_reg_model.dart';

abstract class UserRegistrationDatasource {
  Future<UserRegistrationDtos?> registerUser(
      UserRegistrationRequest userregistrationrequest);

  Future<UserActivateDtos?> activateUser(String qrCode);
}

class UserRegistrationDatasourceImpl extends ApiClient
    implements UserRegistrationDatasource {
  final SharedPreferencesService prefsService = sl<SharedPreferencesService>();
  UserRegistrationDatasourceImpl({required super.client});
  //UserRegister

  Future<UserRegistrationDtos?> registerUser(
      UserRegistrationRequest userregistrationrequest) async {
    final url = Url.baseUrl;

    try {
      final response = await client.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(userregistrationrequest.toJson()));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        UserRegistrationDtos userRegistrationDtos =
            UserRegistrationDtos.fromJson(responseData['d']);

        if (userRegistrationDtos.data != null &&
            userRegistrationDtos.data!.isNotEmpty &&
            userRegistrationDtos.data![0].isNotEmpty &&
            userRegistrationDtos.data![0][0].token != null) {
          String token1 = userRegistrationDtos.data![0][0].token!;
          String tokenExpiry = userRegistrationDtos.data![0][0].tokenExpiry!;

          await prefsService.setToken(token1);
          await prefsService.setTokenExpiry(tokenExpiry);

          print("registerUser Token saved: $token1");
        } else {
          print("registerUser Token not found in response");
        }

        print(responseData);
        return userRegistrationDtos;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      return null;
    }
  }

  //ActivateUser

  Future<UserActivateDtos?> activateUser(String qrCode) async {
    final token1 = await prefsService.getToken();
    final url = Url.baseUrl;
    final requestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_ActivateUser"},
        {"Key": "UserID", "Value": "1"},
        {"Key": "QRCode", "Value": qrCode}
      ]
    });

    try {
      final response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token1'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        UserActivateDtos userActivateDtos =
            UserActivateDtos.fromJson(responseData['d']);

        print(responseData);
        return userActivateDtos;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      return null;
    }
  }
}
