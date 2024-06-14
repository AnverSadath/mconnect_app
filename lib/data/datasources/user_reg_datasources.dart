import 'dart:convert';
import 'package:mconnect_app/domain/request/user_reg_request.dart';
import 'package:mconnect_app/data/models/user_activate_model.dart';
import 'package:mconnect_app/data/models/user_reg_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRegistrationDatasource {
  Future<UserRegistrationDtos?> registerUser(
      UserRegistrationRequest userregistrationrequest);

  Future<UserActivateDtos?> activateUser(String qrCode);
}

class UserRegistrationDatasourceImpl extends UserRegistrationDatasource {
  //UserRegister

  Future<UserRegistrationDtos?> registerUser(
      UserRegistrationRequest userregistrationrequest) async {
    final url =
        "http://manvish.mnets.in/API/CommanAPIRequest.aspx/ReceiveRequestmCOnnect";

    try {
      final response = await http.post(Uri.parse(url),
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

          SharedPreferences prefs1 = await SharedPreferences.getInstance();
          await prefs1.setString("token1", token1);

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
    final url =
        "http://manvish.mnets.in/API/CommanAPIRequest.aspx/ReceiveRequestmCOnnect";

    final requestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_ActivateUser"},
        {"Key": "UserID", "Value": "1"},
        {"Key": "QRCode", "Value": qrCode}
      ]
    });
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    final token1 = prefs1.getString("token1");

    try {
      final response = await http.post(Uri.parse(url),
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
