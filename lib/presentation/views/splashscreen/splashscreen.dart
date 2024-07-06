import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/data/datasources/local_storage.dart';
import 'package:mconnect_app/domain/entities/refresh_token_entities.dart';
import 'package:mconnect_app/presentation/logic/provider/refresh_token_provider.dart';
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

    final SharedPreferencesService prefsService =
        await SharedPreferencesService();

    final token = await prefsService.getToken();
    final tokenExpiry = await prefsService.getTokenExpiry();
    context.goNamed("login");

    if (token != null &&
        tokenExpiry != null &&
        !tokenRefreshProvider.isTokenExpired(tokenExpiry)) {
      // Token is not expired, navigate to home screen
      // context.goNamed("login");
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 90,
                width: 200,
                child: Image.asset("assets/logo.jpeg"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Powered by Manvish Info Solutions",
              style: GoogleFonts.raleway(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          )
        ],
      ),
    );
  }
}
