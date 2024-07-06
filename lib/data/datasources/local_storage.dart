import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService();

  Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token2", token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token2");
  }

  Future<void> setUserId(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("userId", userId);
  }

  Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId") ?? 0;
  }

  Future<void> setTokenExpiry(String tokenExpiry) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("tokenExpiry", tokenExpiry);
  }

  Future<String?> getTokenExpiry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("tokenExpiry");
  }
}
