import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.drive_file_rename_outline_rounded,
                color: Color(0xFFF3D3E8A),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Edit Profile',
                style: GoogleFonts.raleway(
                    fontSize: 14, color: Color(0XFFF707070)),
              ),
            ],
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.brightness_4_sharp,
                color: Color(0xFFF3D3E8A),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Change Mode',
                style: GoogleFonts.raleway(
                    fontSize: 14, color: Color(0XFFF707070)),
              ),
            ],
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove("pin");
              await prefs.remove("isAuthenticated");
              //    await prefs.remove("isScanningComplete");

              context.goNamed("login");
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.power_settings_new_outlined,
                  color: Color(0XFFFEC3333),
                  size: 14,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Logout',
                  style: GoogleFonts.raleway(
                      fontSize: 14, color: Color(0XFFF707070)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
