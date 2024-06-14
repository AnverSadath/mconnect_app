import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/presentation/views/user_login_page/user_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinSettingPage extends StatefulWidget {
  @override
  _PinSettingPageState createState() => _PinSettingPageState();
}

class _PinSettingPageState extends State<PinSettingPage> {
  final _enterpinController = TextEditingController();
  final _confirmpinController = TextEditingController();

  void _setPin() async {
    if (_confirmpinController.text.length == 4) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('pin', _confirmpinController.text);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a 4-digit PIN')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          title: Text(
            'Enter 4-Digit Login PIN',
            style: GoogleFonts.raleway(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            height: MediaQuery.of(context).size.height * 0.875,
            width: MediaQuery.of(context).size.width * double.infinity,
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Padding(
                padding: const EdgeInsets.only(right: 262),
                child: Text(
                  "Enter PIN",
                  style: GoogleFonts.raleway(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 340,
                child: PinCodeFields(
                  animation: Animations.slideInDown,
                  padding: EdgeInsets.only(bottom: 15),
                  controller: _enterpinController,
                  keyboardType: TextInputType.number,
                  textStyle: GoogleFonts.raleway(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    fontSize: 22,
                  ),
                  length: 4,
                  onComplete: (value) {},
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(right: 244),
                child: Text(
                  "Confirm Pin",
                  style: GoogleFonts.raleway(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 340,
                child: PinCodeFields(
                  animation: Animations.slideInDown,
                  padding: EdgeInsets.only(bottom: 15),
                  controller: _confirmpinController,
                  keyboardType: TextInputType.number,
                  textStyle: GoogleFonts.raleway(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    fontSize: 22,
                  ),
                  length: 4,
                  onComplete: (value) {},
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(344, 55)),
                onPressed: _setPin,
                child: Text(
                  'Save',
                  style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(height: 30),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  "Please ensure your MPIN to be as per below policies",
                  style: GoogleFonts.raleway(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            ])));
  }
}

// class PinEntryPage extends StatefulWidget {
//   @override
//   _PinEntryPageState createState() => _PinEntryPageState();
// }

// class _PinEntryPageState extends State<PinEntryPage> {
//   final _pinController = TextEditingController();
//   String? _storedPin;

//   @override
//   void initState() {
//     super.initState();
//     _loadStoredPin();
//   }

//   void _loadStoredPin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _storedPin = prefs.getString('pin');
//     });
//   }

//   void _checkPin() {
//     if (_pinController.text == _storedPin) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('PIN is correct! Welcome to Home Page')),
//       );
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(),
//           ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Incorrect PIN, please try again')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter 4-Digit PIN'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _pinController,
//               decoration: InputDecoration(labelText: 'Enter 4-digit PIN'),
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 4,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _checkPin,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
