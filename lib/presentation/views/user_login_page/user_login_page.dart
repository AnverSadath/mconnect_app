import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mconnect_app/data/models/login_pin_bio_model.dart';
import 'package:mconnect_app/domain/entities/activate_entities.dart';
import 'package:mconnect_app/domain/entities/login_entities.dart';
import 'package:mconnect_app/presentation/logic/provider/user_login_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/user_reg_provider.dart';
import 'package:mconnect_app/presentation/views/homepage/homepage.dart';
import 'package:mconnect_app/utils/validations/login_validations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool visibility = false;
  final _formKey = GlobalKey<FormState>();
  bool isAuthComplete = false;
  bool isPinSet = false;
  final pinController = TextEditingController();
  String? storedPin;
  bool pinError = false;
  String? pinErrorMessage = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStoredPin();
      _loadAuth();
    });
  }

  void _loadStoredPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedPin = prefs.getString('pin');
      isPinSet = prefs.getString('pin') != null;
    });
  }

  void _loadAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAuthComplete = prefs.getBool('isAuthenticated') ?? false;
    });
  }

  void _checkPinInFeild() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    final token2 = prefs2.getString("token2");
    print("old token token2......${token2}");

    if (pinController.text == storedPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PIN is correct! Welcome to Home Page')),
      );

      final loginprovider =
          Provider.of<UserLoginProvider>(context, listen: false);
      LoginPinBioDtos? response = await loginprovider.loginWithPin();

      if (response != null && response.status == 1) {
        context.pushNamed("bottombar");
      } else {
        _showErrorDialog(response!.message ?? "");
      }
    } else {
      setState(() {
        pinError = true;
        pinErrorMessage = "Invalid MPIN. Try again!";
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          pinError = false;
          pinErrorMessage = "";
        });
      });
    }
  }

  Future<bool> _checkAuthentication() async {
    try {
      bool authenticate = await _localAuthentication.authenticate(
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
        localizedReason: 'Verify it\'s you',
      );

      if (authenticate) {
        final loginprovider =
            Provider.of<UserLoginProvider>(context, listen: false);
        LoginPinBioDtos? response = await loginprovider.loginWithBio();
        if (response != null && response.status == 1) {
          context.pushNamed("bottombar");
        }
      }
      return authenticate;
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      return false;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double _calculateContainerHeight(BuildContext context) {
    double normalHeight = MediaQuery.of(context).size.height * 0.51;
    double pinBioSetHeight = MediaQuery.of(context).size.height * 0.35;

    if (isPinSet && isAuthComplete) {
      return normalHeight; // 0.48
    } else if (isPinSet || isAuthComplete) {
      return pinBioSetHeight; // 0.30
    } else {
      return normalHeight; // Default to 0.48
    }
  }

  double _calculateSizedboxHeight(BuildContext context) {
    double normalHeight = MediaQuery.of(context).size.height * 0.040;
    double pinBioSetHeight = MediaQuery.of(context).size.height * 0.200;

    if (isPinSet && isAuthComplete) {
      return normalHeight; // 0.48
    } else if (isPinSet || isAuthComplete) {
      return pinBioSetHeight; // 0.30
    } else {
      return normalHeight; // Default to 0.48
    }
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Text("Login",
                  style: GoogleFonts.raleway(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Column(children: [
            SizedBox(height: 140),
            Container(
              height: 258,
              width: 280,
              child: Image.asset("assets/login-img.png"),
            ),
            SizedBox(height: _calculateSizedboxHeight(context)),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)),
                ),
                height: _calculateContainerHeight(context),
                width: MediaQuery.of(context).size.width * double.infinity,
                child: isPinSet || isAuthComplete
                    ? SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.045),
                              if (isPinSet)
                                Column(
                                  children: [
                                    isPinSet && isAuthComplete
                                        ? Text(
                                            "Enter MPIN",
                                            style: GoogleFonts.raleway(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer),
                                          )
                                        : Text("Login with MPIN",
                                            style: GoogleFonts.raleway(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer)),
                                    isAuthComplete && isPinSet
                                        ? SizedBox(
                                            height: 10,
                                          )
                                        : SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.030),
                                    Container(
                                      width: 330,
                                      child: PinCodeFields(
                                        animation: Animations.slideInDown,
                                        fieldBorderStyle:
                                            FieldBorderStyle.square,
                                        borderColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceBright,
                                        fieldHeight: 40,
                                        fieldBackgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        controller: pinController,
                                        padding: EdgeInsets.only(bottom: 8),
                                        keyboardType: TextInputType.number,
                                        textStyle: GoogleFonts.raleway(
                                          color: pinError
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer,
                                          fontSize: 22,
                                        ),
                                        length: 4,
                                        onComplete: (value) async {
                                          _checkPinInFeild();
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    if (pinError)
                                      Text(
                                        "$pinErrorMessage",
                                        style: GoogleFonts.raleway(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                      )
                                  ],
                                ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.020),
                              if (isPinSet && isAuthComplete)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer),
                                    Text("Or",
                                        style: GoogleFonts.raleway(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                          fontSize: 14,
                                        )),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                    ),
                                  ],
                                ),
                              isAuthComplete && isPinSet
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.030)
                                  : SizedBox(),
                              if (isAuthComplete)
                                Column(children: [
                                  isAuthComplete && isPinSet
                                      ? SizedBox()
                                      : Text(
                                          "Login with Touch ID",
                                          style: GoogleFonts.raleway(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer),
                                        ),
                                  isAuthComplete && isPinSet
                                      ? SizedBox()
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.040,
                                        ),
                                  InkWell(
                                    onTap: () {
                                      _checkAuthentication();
                                    },
                                    child: Container(
                                      height: 90,
                                      width: 85,
                                      child:
                                          Image.asset("assets/fingerlogo.png"),
                                    ),
                                  ),
                                  isAuthComplete && isPinSet
                                      ? SizedBox(height: 40)
                                      : SizedBox(),
                                  isAuthComplete && isPinSet
                                      ? RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              style: GoogleFonts.raleway(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimaryContainer),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "Use your Touch ID for faster,easier\n"),
                                                TextSpan(
                                                    text:
                                                        "access to your account")
                                              ]))
                                      : SizedBox()
                                ])
                            ]),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    controller: namecontroller,
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      filled: true,
                                      suffixIcon: Icon(
                                        Icons.person_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      hintText: "Mobile/Email ID",
                                      hintStyle: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(17)),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      errorStyle: TextStyle(height: 0.2),
                                    ),
                                    validator: (value) =>
                                        LoginValidations.validateEmailmobile(
                                            value)),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextFormField(
                                    obscureText: !visibility,
                                    controller: passwordcontroller,
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      filled: true,
                                      suffixIcon: IconButton(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          onPressed: () {
                                            setState(() {
                                              visibility = !visibility;
                                            });
                                          },
                                          icon: visibility
                                              ? Icon(
                                                  Icons.visibility_outlined,
                                                )
                                              : Icon(Icons
                                                  .visibility_off_outlined)),
                                      hintText: "Password",
                                      hintStyle: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(17)),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      errorStyle: TextStyle(height: 0.2),
                                    ),
                                    validator: (value) =>
                                        LoginValidations.validatePassword(
                                            value)),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        minimumSize: Size(344, 55)),
                                    onPressed: () async {
                                      // SharedPreferences prefs =
                                      //     await SharedPreferences
                                      //         .getInstance();
                                      // bool isScanningComplete = prefs.getBool(
                                      //         "isScanningComplete") ??
                                      //     false;

                                      // if (!isScanningComplete) {
                                      //   context.pushNamed("qrscanner");
                                      //   return;
                                      // }

                                      if (_formKey.currentState!.validate()) {
                                        final loginprovider =
                                            Provider.of<UserLoginProvider>(
                                                context,
                                                listen: false);
                                        LoginEntities? response =
                                            await loginprovider.loginuser(
                                                namecontroller.text,
                                                passwordcontroller.text);

                                        if (response != null &&
                                            response.status == 1) {
                                          context.pushNamed("bottombar");
                                        } else {
                                          _showErrorDialog(
                                              response!.message ?? "");
                                        }
                                      }
                                    },
                                    child: Text("Login",
                                        style: GoogleFonts.raleway(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 18))),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer),
                                    Text("Or",
                                        style: GoogleFonts.raleway(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                          fontSize: 14,
                                        )),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text("Dont Have an Account?",
                                    style: GoogleFonts.raleway(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 14,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      context.pushNamed("registration");
                                    },
                                    child: Text("Register",
                                        style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            )
          ]),
        ]));
  }
}
