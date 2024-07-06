import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mconnect_app/presentation/logic/provider/mpinset_provider.dart';
import 'package:mconnect_app/presentation/views/homepage/profile_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAuthenticated = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool showAllContainers = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkMpinAndAuthStatus();
    });
  }

  Future<void> _checkMpinAndAuthStatus() async {
    final mpinSetProvider =
        Provider.of<MpinSetProvider>(context, listen: false);
    await mpinSetProvider.checkMpinStatus();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    });

    if (!mpinSetProvider.isMpinSet && !isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mainBottomSheet(context);
      });
    }
  }

  Future<bool> _authenticate() async {
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isAuthenticated', true);

        setState(() {
          isAuthenticated = true;
        });
      }
      return authenticate;
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      return false;
    }
  }

  void _mainBottomSheet(BuildContext context) {
    final mpinSetProvider =
        Provider.of<MpinSetProvider>(context, listen: false);
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(30)),
          height: MediaQuery.of(context).size.height * 0.380,
          width: MediaQuery.of(context).size.width * double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                  left: 350,
                ),
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 35,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
              Text(
                'Want to change login?',
                style: GoogleFonts.raleway(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 20),
              Text(
                "Try MPIN or Fingerprint instead",
                style: GoogleFonts.raleway(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!mpinSetProvider.isMpinSet)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            minimumSize: const Size(170, 60)),
                        onPressed: () {
                          context.pop();
                          context.pushNamed("pinsetting").then((_) {
                            _checkMpinAndAuthStatus();
                          });
                        },
                        child: Text("Set MPIN",
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onPrimary))),
                  if (!isAuthenticated)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            minimumSize: const Size(170, 60)),
                        onPressed: () async {
                          bool isAuthenticated = await _authenticate();
                          if (isAuthenticated) {
                            context.pop();
                            _AuthSuccessBottomSheet();
                          }
                        },
                        child: Text("Use Fingerprint",
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onPrimary))),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: 361,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFF3D3E8A),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(100))),
                ),
                Positioned(
                  top: -180,
                  bottom: 200,
                  left: 60,
                  child: ClipRect(
                    clipBehavior: Clip.antiAlias,
                    child: Align(
                      alignment: Alignment.topRight,
                      heightFactor: 0.5,
                      child: CircleAvatar(
                        radius: 174,
                        backgroundColor: Color.fromARGB(255, 72, 72, 124),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -220,
                  bottom: 80,
                  left: 250,
                  child: ClipRect(
                    clipBehavior: Clip.antiAlias,
                    child: Align(
                      alignment: Alignment.topRight,
                      heightFactor: 0.5,
                      child: CircleAvatar(
                        radius: 240,
                        backgroundColor: Color.fromARGB(255, 88, 88, 140),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                      left: 17,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hello! Goodmorning',
                              style: GoogleFonts.raleway(
                                fontSize: 17,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            SizedBox(width: 125),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_none,
                                size: 25,
                              ),
                              color: Color(0xFFFFFFFF),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => FluidDialog(
                                    defaultDecoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    // Setting the first dialog page.
                                    rootPage: FluidDialogPage(
                                      alignment: Alignment.topRight,
                                      builder: (context) => SizedBox(
                                          height: 120,
                                          width: 200,
                                          child: ProfileDialog()),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.person_outline,
                                size: 25,
                              ),
                              color: Color(0xFFFFFFFF),
                            ),
                          ],
                        ),
                        Text(
                          'check-in:',
                          style: GoogleFonts.raleway(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 358,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xFFF7070A7),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: GoogleFonts.raleway(
                                fontWeight: FontWeight.normal,
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                size: 20,
                                color: Color(0xFFFFFFFF),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 185, right: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed('supportrequest');
                        },
                        child: Container(
                          width: 165,
                          height: 210,
                          decoration: BoxDecoration(
                            color: Color(0xFFE2D3F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    color: Color(0xFFA288CE),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(
                                  Icons.headset_mic_rounded,
                                  size: 50,
                                  color: Color(0xFF7656AB),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Support ',
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF7E5BB8),
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                "Request",
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF7E5BB8),
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(height: 10),
                              CircleAvatar(
                                backgroundColor: Color(0xFFB29BD8),
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {},
                                  color: Color(0xFFFFFFFF),
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed("onsiterequest");
                        },
                        child: Container(
                          width: 165,
                          height: 210,
                          decoration: BoxDecoration(
                            color: Color(0XFFB9E5F2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    color: Color(0xFF8AC4D4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Icon(
                                  Icons.edit_note_sharp,
                                  size: 50,
                                  color: Color(0xFF4D90A2),
                                ),
                              ),
                              SizedBox(height: 8),
                              Column(
                                children: [
                                  Text(
                                    'Onsite',
                                    style: GoogleFonts.raleway(
                                      color: Color(0xFF5FA9BC),
                                      fontSize: 19,
                                    ),
                                  ),
                                  Text(
                                    'Request',
                                    style: GoogleFonts.raleway(
                                      color: Color(0xFF5FA9BC),
                                      fontSize: 19,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              CircleAvatar(
                                backgroundColor: Color(0xFF8AC4D4),
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {},
                                  color: Color(0xFFFFFFFF),
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                "Recent Requests",
                style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D3E8A)),
              ),
              SizedBox(width: 40),
              Text(
                "See All",
                style: GoogleFonts.raleway(
                    color: Color(0XFFF2F52A2),
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ]),
            SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 120.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
              ),
              items: List.generate(3, (index) {
                return Container(
                  width: 343,
                  height: 115,
                  decoration: BoxDecoration(
                      color: Color(0xFFFEAEAFF),
                      borderRadius: BorderRadius.circular(20)),
                );
              }),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Product Gallery",
                  style: GoogleFonts.raleway(
                      color: Color(0xFFF3D3E8A),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All",
                    style: GoogleFonts.raleway(
                      color: Color(0XFFF2F52A2),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFFECEC),
                      borderRadius: BorderRadius.circular(32)),
                  height: 90,
                  width: 110,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAFF),
                      borderRadius: BorderRadius.circular(32)),
                  height: 90,
                  width: 110,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFFEAFF),
                      borderRadius: BorderRadius.circular(32)),
                  height: 90,
                  width: 110,
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 235),
              child: Text(
                "Feedbacks",
                style: GoogleFonts.raleway(
                    color: Color(0xFF3D3E8A),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 114,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFF6F8FF)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "We appreciate your Feedback!",
                      style: GoogleFonts.raleway(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F52A2)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
            )
          ]),
        ));
  }

  // Column(
  //   children: [
  //     ElevatedButton(
  //       onPressed: () {
  //         _mainBottomSheet(context);
  //       },
  //       child: const Text("Show Bottom Sheet"),
  //     ),
  //     ElevatedButton(
  //       onPressed: () {
  //         _AuthSuccessBottomSheet();
  //       },
  //       child: const Text("Show Success Bottom Sheet"),
  //     ),
  //     IconButton(
  //       onPressed: () async {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.remove("pin");
  //         await prefs.remove("isAuthenticated");
  //         await prefs.remove("isScanningComplete");

  //         context.pop();
  //       },
  //       icon: const Icon(Icons.logout),
  //     ),
  //   ],
  // ),
  //   );
  //}

  void _AuthSuccessBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          context.pop();
        });
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(30)),
          height: MediaQuery.of(context).size.height * 0.470,
          width: MediaQuery.of(context).size.width * double.infinity,
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0650,
            ),
            Text(
              'You have successfully\n  set your Fingerprint!',
              style: GoogleFonts.raleway(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            Container(
              height: 90,
              width: 85,
              child: Image.asset("assets/fingerlogo.png"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                children: [
                  TextSpan(text: 'You can change login as '),
                  TextSpan(
                    text: 'Username',
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  TextSpan(
                    text: ' or ',
                    style: GoogleFonts.raleway(
                        fontSize: 12,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  TextSpan(
                    text: 'MPIN',
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  TextSpan(
                    text: ' later\nfrom settings page.',
                    style: GoogleFonts.raleway(
                        fontSize: 12,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ],
              ),
            )
          ]),
        );
      },
    );
  }
}
