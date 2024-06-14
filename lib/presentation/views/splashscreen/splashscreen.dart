import 'package:flutter/material.dart';
import 'package:mconnect_app/data/datasources/refresh_token_datasources.dart';
import 'package:mconnect_app/data/models/refresh_token_model.dart';
import 'package:mconnect_app/domain/entities/refresh_token_entities.dart';
import 'package:mconnect_app/domain/repositories/refresh_token_repo.dart';
import 'package:mconnect_app/presentation/logic/provider/refresh_token_provider.dart';
import 'package:mconnect_app/presentation/views/user_login_page/user_login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TokenDatasourceImpl tokenDatasource = TokenDatasourceImpl();

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    await Future.delayed(Duration(seconds: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token2");
    final tokenExpiry = prefs.getString("tokenExpiry");

    if (token != null &&
        tokenExpiry != null &&
        !tokenDatasource.isTokenExpired(tokenExpiry)) {
      // Token is not expired, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      print("Token is not expired");
    } else {
      print("Token is expired");

      final tokenrefresh =
          Provider.of<TokenRefreshProvider>(context, listen: false);
      RefreshTokenEntities? response = await tokenrefresh.tokenRefresh();
      if (response != null && response.status == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Homepage"),
      ),
    );
  }
}
