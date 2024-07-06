import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:mconnect_app/core/injection_container.dart" as injection;
import 'package:mconnect_app/core/injection_container.dart';
import 'package:mconnect_app/presentation/logic/provider/loading_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/mpinset_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/onsite_request_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/refresh_token_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/support_request_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/user_login_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/user_reg_provider.dart';
import 'package:mconnect_app/presentation/views/all_requests_list/all_requests_list.dart';
import 'package:mconnect_app/presentation/views/bottombar/bottombar.dart';
import 'package:mconnect_app/presentation/views/homepage/homepage.dart';
import 'package:mconnect_app/presentation/views/onsite_request_page/onsite_request_page.dart';
import 'package:mconnect_app/presentation/views/pin_setting_page/pin_setting_page.dart';
import 'package:mconnect_app/presentation/views/qr_scanner_page/qr_scanner_page.dart';
import 'package:mconnect_app/presentation/views/registration_success_page/registration_success_page.dart';
import 'package:mconnect_app/presentation/views/splashscreen/splashscreen.dart';
import 'package:mconnect_app/presentation/views/support_request_page/support_request_page.dart';
import 'package:mconnect_app/presentation/views/user_login_page/user_login_page.dart';
import 'package:mconnect_app/presentation/views/user_reg_page/user_reg_page.dart';
import 'package:provider/provider.dart';

void main() {
  injection.prepareSL();
  runApp(const MconnectApp());
}

class MconnectApp extends StatefulWidget {
  const MconnectApp({super.key});

  @override
  State<MconnectApp> createState() => _MconnectAppState();
}

class _MconnectAppState extends State<MconnectApp> {
  final _router = GoRouter(routes: [
    GoRoute(
      name: "splashscreen",
      path: "/",
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
        name: "registration",
        path: "/registerpage",
        builder: (context, state) => RegistrationPage()),
    GoRoute(
      name: "login",
      path: "/loginpage",
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: "qrscanner",
      path: "/qrscannerpage",
      builder: (context, state) => QRScannerPage(),
    ),
    GoRoute(
      name: "regsuccess",
      path: "/regsuccesspage",
      builder: (context, state) => RegistrationSuccess(),
    ),
    GoRoute(
      name: "bottombar",
      path: "/bottombarpage",
      builder: (context, state) => Bottombar(),
    ),
    GoRoute(
      name: "home",
      path: "/homepage",
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      name: "allrequests",
      path: "/allrequestspage",
      builder: (context, state) => AllRequestsList(),
    ),
    GoRoute(
      name: "supportrequest",
      path: "/supportrequest",
      builder: (context, state) => SupportRequestPage(),
    ),
    GoRoute(
      name: "onsiterequest",
      path: "/onsiterequestpage",
      builder: (context, state) => OnsiteRequestPage(),
    ),
    GoRoute(
      name: "pinsetting",
      path: "/pinsettingpage",
      builder: (context, state) => PinSettingPage(),
    )
  ]);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<UserLoginProvider>()),
        ChangeNotifierProvider(
            create: (context) => sl<UserRegistrationProvider>()),
        ChangeNotifierProvider(create: (context) => sl<TokenRefreshProvider>()),
        ChangeNotifierProvider(
          create: (context) => sl<SupportRequestProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<OnsiteRequestProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => MpinSetProvider(),
        ),
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
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
                surface: Color(0xFFF2F5FC),
                onSurface: Color(0xFF00AFEF),
                surfaceBright: Color(0xFF707070))),
      ),
    );
  }
}
