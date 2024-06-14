import 'package:flutter/material.dart';
import "package:mconnect_app/core/injection_container.dart" as injection;
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/presentation/logic/provider/refresh_token_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/user_login_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/user_reg_provider.dart';
import 'package:mconnect_app/presentation/views/pin_setting_page/pin_setting_page.dart';
import 'package:provider/provider.dart';

void main() {
  injection.prepareSL();
  runApp(const MconnectApp());
}

class MconnectApp extends StatelessWidget {
  const MconnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<UserLoginProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<UserRegistrationProvider>()),
        ChangeNotifierProvider(create: (context) => sl<TokenRefreshProvider>())
      ],
      child: MaterialApp(
          home: PinSettingPage(),
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.transparent,
                  primary: Color(0xFF3D3E8A),
                  onPrimary: Color(0xFFFFFFFF),
                  primaryContainer: Color(0xFFF4F5F7),
                  onPrimaryContainer: Color(0xFF98A6BE),
                  secondary: Color(0xFF42526E),
                  onSecondary: Colors.red,
                  secondaryContainer: Color(0xFF2F52A2),
                  onSecondaryContainer: Color(0xFFEAEAEA),
                  background: Color(0xFFF2F5FC),
                  onBackground: Color(0xFF172B4D)))),
    );
  }
}
