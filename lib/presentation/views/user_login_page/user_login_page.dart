import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mconnect_app/data/datasources/user_login_datasources.dart';
import 'package:mconnect_app/data/models/login_pin_bio_model.dart';
import 'package:mconnect_app/data/models/user_login_model.dart';
import 'package:mconnect_app/domain/entities/login_entities.dart';
import 'package:mconnect_app/presentation/logic/provider/user_login_provider.dart';
import 'package:mconnect_app/presentation/views/homepage/homepage.dart';
import 'package:mconnect_app/presentation/views/pin_setting_page/pin_setting_page.dart';
import 'package:mconnect_app/presentation/views/user_reg_page/user_reg_page.dart';
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

  bool _fingerprintAuthCompleted = false;
  bool _isPinSet = false;
  final pinController = TextEditingController();
  String? storedPin;

  @override
  void initState() {
    super.initState();
    _checkPin();
    _loadStoredPin();
  }

  void _checkPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPinSet = prefs.containsKey('pin');
    });
  }

  void _loadStoredPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedPin = prefs.getString('pin');
    });
  }

  void _checkPin2() {
    if (pinController.text == storedPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PIN is correct! Welcome to Home Page')),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect PIN, please try again')),
      );
    }
  }

  Future<void> _showFingerprintDialog() async {
    bool useFingerprint = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Fingerprint Authentication'),
        content: Text('Do you want to use fingerprint authentication?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true); // User selected Yes
              bool isAuthenticated = await _authenticate();
              if (isAuthenticated) {
                setState(() {
                  _fingerprintAuthCompleted = true;
                });
              }
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User selected No
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  Future<bool> _authenticate() async {
    try {
      return await _localAuthentication.authenticate(
        options: AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
        localizedReason: 'Verify its you',
      );
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      return false;
    }
  }

  Future<bool> _authenticate2() async {
    try {
      // Perform biometric authentication
      return await _localAuthentication.authenticate(
        options: AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
        localizedReason: 'Authenticate to login',
      );

      // Check if biometric authentication succeeded and login credentials are correct
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      return false; // Authentication failed due to an error
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

  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("Login",
              style: GoogleFonts.raleway(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
          centerTitle: true,
          elevation: 0,
        ),
        body:
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextFormField(
            //         controller: namecontroller,
            //         decoration: InputDecoration(
            //             hintText: "username", border: OutlineInputBorder())),
            //     SizedBox(height: 20),
            //     TextFormField(
            //         controller: passwordcontroller,
            //         decoration: InputDecoration(
            //             hintText: "password", border: OutlineInputBorder())),
            //     ElevatedButton(
            //         onPressed: () async {
            //           final loginprovider =
            //               Provider.of<UserLoginProvider>(context, listen: false);
            //           UserLoginDtos? response = await loginprovider.loginuser(
            //               namecontroller.text, passwordcontroller.text);

            //           if (response != null && response.status == 1) {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => HomePage(),
            //                 ));
            //           } else {
            //             _showErrorDialog(response!.message ?? "");
            //           }
            //         },
            //         child: Text("Login")),
            //     _fingerprintAuthCompleted == false
            //         ? ElevatedButton(
            //             onPressed: () async {
            //               await _showFingerprintDialog();
            //             },
            //             child: Text('Use Fingerprint to Login'),
            //           )
            //         : ElevatedButton(
            //             onPressed: () async {
            //               bool isAuthenticate = await _authenticate2();
            //               if (isAuthenticate) {
            //                 SharedPreferences prefs2 =
            //                     await SharedPreferences.getInstance();
            //                 final token2 = prefs2.getString("token2");

            //                 print("old token token2......${token2}");

            //                 final loginprovider = Provider.of<UserLoginProvider>(
            //                     context,
            //                     listen: false);
            //                 LoginPinBioDtos? response =
            //                     await loginprovider.loginWithBio();
            //                 if (response != null && response.status == 1) {
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(builder: (context) => HomePage()),
            //                   );
            //                 } else {
            //                   _showErrorDialog('Biometric login failed');
            //                 }
            //               }
            //             },
            //             child: Icon(Icons.fingerprint)),
            //     SizedBox(height: 20),
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => PinSettingPage()),
            //         ).then((_) {
            //           _checkPin();
            //           _loadStoredPin(); // Refresh the state after setting the pin
            //         });
            //       },
            //       child: Text('Set 4-Digit PIN'),
            //     ),
            //     if (_isPinSet) ...[
            //       TextField(
            //         controller: pinController,
            //         decoration: InputDecoration(labelText: 'Enter 4-digit PIN'),
            //         keyboardType: TextInputType.number,
            //         //obscureText: true,
            //         maxLength: 4,
            //       ),
            //       SizedBox(height: 20),
            //       ElevatedButton(
            //         onPressed: () async {
            //           SharedPreferences prefs2 =
            //               await SharedPreferences.getInstance();
            //           final token2 = prefs2.getString("token2");

            //           print("old token token2......${token2}");

            //           final loginprovider =
            //               Provider.of<UserLoginProvider>(context, listen: false);

            //           LoginPinBioDtos? response = await loginprovider.loginWithPin();

            //           _checkPin2();
            //         },
            //         child: Text('Login'),
            //       ),
            //     ]
            //   ],
            // ),
            Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            ),
            height: MediaQuery.of(context).size.height * 0.52,
            width: MediaQuery.of(context).size.width * double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          filled: true,
                          suffixIcon: Icon(
                            Icons.person_outlined,
                            color: Theme.of(context).colorScheme.secondary,
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
                              borderRadius: BorderRadius.circular(17)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          errorStyle: TextStyle(height: 0.2),
                        ),
                        validator: (value) =>
                            LoginValidations.validateEmailmobile(value)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                        obscureText: !visibility,
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          filled: true,
                          suffixIcon: IconButton(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: visibility
                                  ? Icon(
                                      Icons.visibility_outlined,
                                    )
                                  : Icon(Icons.visibility_off_outlined)),
                          hintText: "Password",
                          hintStyle: GoogleFonts.raleway(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(17)),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17),
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          errorStyle: TextStyle(height: 0.2),
                        ),
                        validator: (value) =>
                            LoginValidations.validatePassword(value)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: Size(344, 55)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final loginprovider =
                                Provider.of<UserLoginProvider>(context,
                                    listen: false);
                            LoginEntities? response =
                                await loginprovider.loginuser(
                                    namecontroller.text,
                                    passwordcontroller.text);

                            if (response != null && response.status == 1) {
                              context.pushNamed("home");
                            } else {
                              _showErrorDialog(response!.message ?? "");
                            }
                          }
                        },
                        child: Text("Login",
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 18))),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width * 0.38,
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
                          width: MediaQuery.of(context).size.width * 0.38,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text("Dont Have an Account?",
                        style: GoogleFonts.raleway(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                            )))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
