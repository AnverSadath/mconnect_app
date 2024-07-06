import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mconnect_app/core/constants/url.dart';
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/data/datasources/api_http_client.dart';
import 'package:mconnect_app/data/datasources/local_storage.dart';
import 'package:mconnect_app/data/models/refresh_token_model.dart';

abstract class TokenDatasource {
  Future<RefreshTokenDtos?> tokenRefresh();
  bool isTokenExpired(String? tokenExpiry);
}

class TokenDatasourceImpl extends ApiClient implements TokenDatasource {
  final SharedPreferencesService prefsService = sl<SharedPreferencesService>();
  TokenDatasourceImpl({required super.client});

  @override
  Future<RefreshTokenDtos?> tokenRefresh() async {
    // SharedPreferences prefs2 = await SharedPreferences.getInstance();
    final token2 = await prefsService.getToken();
    final userId = await prefsService.getUserId();
    final tokenExpiry = await prefsService.getTokenExpiry();

    //  Check if token exists and not expired
    if (token2 != null && !isTokenExpired(tokenExpiry)) {
      print("Token exists and not expired. No need to refresh.");
      return null;
    }

    final url = Url.baseUrl;

    final requestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_GetData"},
        {"Key": "Method", "Value": "RefreshToken"},
        {"Key": "UserID", "Value": userId}
      ]
    });

    try {
      final response = await client.post(Uri.parse(url),
          body: requestBody,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token2'
          });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Response Data: $responseData");

        if (responseData.containsKey('d')) {
          RefreshTokenDtos refreshTokenDtos =
              RefreshTokenDtos.fromJson(responseData['d']);

          if (refreshTokenDtos.data != null &&
              refreshTokenDtos.data!.isNotEmpty &&
              refreshTokenDtos.data![0].isNotEmpty) {
            String? newToken = refreshTokenDtos.data![0][0].token;
            String? tokenExpiryDate = refreshTokenDtos.data![0][0].tokenExpiry;

            if (newToken != null) {
              await prefsService.setToken(newToken);
              if (tokenExpiryDate != null) {
                await prefsService.setTokenExpiry(tokenExpiryDate);
              }
              print("Token Refreshed Successfully: $newToken");
              return refreshTokenDtos;
            }
          }
          print("Token refresh failed: New token not found in response");
        } else {
          print("Token refresh failed: Response does not contain 'd'.");
        }
        return null;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error during HTTP request: $e");
      return null;
    }
  }

  bool isTokenExpired(String? tokenExpiry) {
    if (tokenExpiry == null) {
      return true;
    }

    try {
      // Normalize whitespace: replace multiple spaces with a single space
      tokenExpiry = tokenExpiry.replaceAll(RegExp(r'\s+'), ' ');

      print("Token expiry date: '$tokenExpiry'"); // Debug print statement
      DateTime expiryDate = DateFormat("MMM dd yyyy hh:mma").parse(tokenExpiry);
      return expiryDate.isBefore(DateTime.now());
    } catch (e) {
      print("Error parsing token expiry date: $e");
      return true;
    }
  }
}
