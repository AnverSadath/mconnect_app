import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/presentation/views/all_requests_list/all_requests_list.dart';
import 'package:mconnect_app/presentation/views/homepage/bottom_dialog.dart';
import 'package:mconnect_app/presentation/views/homepage/homepage.dart';

import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0; // Index of the selected tab

  // List of widgets that correspond to each tab
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AllRequestsList(),
    HomePage(),
    HomePage(),
  ];

  // Function to handle tab selection`
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 74,
        child: StylishBottomBar(
          elevation: 50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          option: AnimatedBarOptions(
            iconSize: 32,
            barAnimation: BarAnimation.fade,
            iconStyle: IconStyle.animated,
            opacity: 0.3,
          ),
          items: [
            BottomBarItem(
              icon: const Icon(
                Icons.home_outlined,
              ),
              selectedIcon: const Icon(Icons.home_outlined),
              selectedColor: Color(0xFF3D3E8A),
              unSelectedColor: Color(0xFFAFAFAF),
              title: Text(
                'Home',
                style: GoogleFonts.raleway(color: Color(0xFF00AFEF)),
              ),
            ),
            BottomBarItem(
              icon: const Icon(Icons.credit_card_outlined),
              selectedIcon: const Icon(Icons.credit_card_outlined),
              selectedColor: Color(0xFF3D3E8A),
              unSelectedColor: Color(0xFFAFAFAF),
              title: Text("Requests",
                  style: GoogleFonts.raleway(color: Color(0xFF00AFEF))),
            ),
            BottomBarItem(
                icon: const Icon(
                  Icons.card_membership_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.card_membership_outlined,
                ),
                selectedColor: Color(0xFF3D3E8A),
                unSelectedColor: Color(0xFFAFAFAF),
                title: Text('Subscriptions',
                    style: GoogleFonts.raleway(color: Color(0xFF00AFEF)))),
            BottomBarItem(
                icon: const Icon(
                  Icons.settings_outlined,
                ),
                selectedIcon: const Icon(Icons.settings_outlined),
                selectedColor: Color(0xFF3D3E8A),
                unSelectedColor: Color(0xFFAFAFAF),
                title: Text('Settings',
                    style: GoogleFonts.raleway(color: Color(0xFF00AFEF)))),
          ],
          hasNotch: true,
          notchStyle: NotchStyle.circle,
          fabLocation: StylishBarFabLocation.center,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: Color(0xFF00AFEF),
        radius: 34,
        child: FloatingActionButton(
          elevation: 0,
          child: Icon(
            color: Color(0xFFFFFFFF),
            Icons.headset_mic_rounded,
            size: 28,
          ),
          shape: CircleBorder(),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: FluidDialog(
                  defaultDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  rootPage: FluidDialogPage(
                    alignment: Alignment.bottomCenter,
                    builder: (context) => SizedBox(child: BottomDialog()),
                  ),
                ),
              ),
            );
          },
          backgroundColor: Color(0xFF00AFEF),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
