import 'package:http/http.dart';

abstract class ApiClient {
  final Client client;

  ApiClient({required this.client});
}
