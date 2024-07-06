import 'dart:convert';
import 'package:mconnect_app/core/constants/url.dart';
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/data/datasources/api_http_client.dart';
import 'package:mconnect_app/data/datasources/local_storage.dart';
import 'package:mconnect_app/data/models/support_request_model.dart';
import 'package:mconnect_app/data/models/view_support_list_model.dart';
import 'package:mconnect_app/domain/request/support_request.dart';

abstract class SupportRequestDatasources {
  Future<SupportRequestDtos?> support(SupportRequest supportRequest);
  Future<ViewSupportListDtos?> viewSupport();
}

class SupportRequestDatasourcesImpl extends ApiClient
    implements SupportRequestDatasources {
  final SharedPreferencesService prefsService = sl<SharedPreferencesService>();

  SupportRequestDatasourcesImpl({required super.client});

  Future<SupportRequestDtos?> support(SupportRequest supportRequest) async {
    final userId = await prefsService.getUserId();
    final token2 = await prefsService.getToken();

    final url = Url.baseUrl;
    try {
      final response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token2'
          },
          body: jsonEncode(supportRequest.toJson(userId)));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        SupportRequestDtos supportRequestDtos =
            SupportRequestDtos.fromJson(responseData['d']);

        print(responseData);
        return supportRequestDtos;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      return null;
    }
  }

  Future<ViewSupportListDtos?> viewSupport() async {
    final userId = await prefsService.getUserId();
    final token2 = await prefsService.getToken();

    final url = Url.baseUrl;
    final requestBody = jsonEncode({
      "request": [
        {"Key": "type", "Value": "mConnectApp_GetData"},
        {"Key": "Method", "Value": "SupportCalls"},
        {"Key": "PageNo", "Value": "1"},
        {"Key": "PageSize", "Value": "10"},
        {"Key": "UserID", "Value": userId}
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
        print("Response Data: $responseData");

        if (responseData['d'] != null) {
          final ViewSupportListDtos viewSupportListDtos =
              ViewSupportListDtos.fromJson(responseData['d']);
          print("Parsed Data: $viewSupportListDtos");
          return viewSupportListDtos;
        } else {
          print('Response data "d" is null');
          return null;
        }
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
