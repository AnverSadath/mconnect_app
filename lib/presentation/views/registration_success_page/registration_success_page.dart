import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/presentation/views/user_login_page/user_login_page.dart';

class RegistrationSuccess extends StatefulWidget {
  const RegistrationSuccess({super.key});

  @override
  State<RegistrationSuccess> createState() => _RegistrationSuccessState();
}

class _RegistrationSuccessState extends State<RegistrationSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FC),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.166),
          Container(
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            height: MediaQuery.of(context).size.height * 0.829,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 80),
                Text("Registration",
                    style: GoogleFonts.raleway(
                        fontSize: 30,
                        color: Color(0xFF3D3E8A),
                        fontWeight: FontWeight.bold)),
                Text("Successfully!",
                    style: GoogleFonts.raleway(
                        fontSize: 30,
                        color: Color(0xFF3D3E8A),
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text("You have Successfully registered with us!",
                    style: GoogleFonts.raleway(
                        fontSize: 13, color: Color(0xFF98A6BE))),
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(144, 55),
                      backgroundColor: Color(0xFF2F52A2)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: Text(
                    "Go to Home",
                    style: GoogleFonts.raleway(
                        fontSize: 18, color: Color(0xFFFFFFFF)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
