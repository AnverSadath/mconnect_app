import 'dart:convert';

import 'package:mconnect_app/core/constants/url.dart';
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/data/datasources/api_http_client.dart';
import 'package:mconnect_app/data/datasources/local_storage.dart';
import 'package:mconnect_app/data/models/onsite_request_model.dart';
import 'package:mconnect_app/domain/request/onsite_request.dart';

abstract class OnsiteRequestDatasources {
  Future<OnsiteRequestDtos?> onsite(OnsiteRequest onsiteRequest);
}

class OnsiteRequestDatasourcesImpl extends ApiClient
    implements OnsiteRequestDatasources {
  final SharedPreferencesService prefsService = sl<SharedPreferencesService>();
  OnsiteRequestDatasourcesImpl({required super.client});

  Future<OnsiteRequestDtos?> onsite(OnsiteRequest onsiteRequest) async {
    final userId = await prefsService.getUserId();
    final token2 = await prefsService.getToken();
    final url = Url.baseUrl;
    try {
      final response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token2'
          },
          body: jsonEncode(onsiteRequest.toJson(userId)));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        OnsiteRequestDtos onsitetRequestDtos =
            OnsiteRequestDtos.fromJson(responseData['d']);

        print(responseData);
        return onsitetRequestDtos;
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
