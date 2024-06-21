import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/domain/entities/refresh_token_entities.dart';
import 'package:mconnect_app/presentation/logic/provider/refresh_token_provider.dart';
import 'package:mconnect_app/presentation/views/user_login_page/user_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late TokenRefreshProvider tokenRefreshProvider;

  @override
  void initState() {
    super.initState();
    tokenRefreshProvider = sl<TokenRefreshProvider>();
    checkToken();
  }

  Future<void> checkToken() async {
    await Future.delayed(Duration(seconds: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token2");
    final tokenExpiry = prefs.getString("tokenExpiry");

    if (token != null &&
        tokenExpiry != null &&
        !tokenRefreshProvider.isTokenExpired(tokenExpiry)) {
      // Token is not expired, navigate to home screen
      context.goNamed("login");
      print("Token is not expired");
    } else {
      print("Token is expired");

      RefreshTokenEntities? response =
          await tokenRefreshProvider.tokenRefresh();
      if (response != null && response.status == 1) {
        context.goNamed("login");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Loading indicator
      ),
    );
  }
}
