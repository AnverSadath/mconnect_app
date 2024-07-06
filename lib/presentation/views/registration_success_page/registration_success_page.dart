import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationSuccess extends StatefulWidget {
  const RegistrationSuccess({super.key});

  @override
  State<RegistrationSuccess> createState() => _RegistrationSuccessState();
}

class _RegistrationSuccessState extends State<RegistrationSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.122),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28))),
              height: MediaQuery.of(context).size.height * 0.875,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Text("Registration",
                      style: GoogleFonts.raleway(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                  Text("Successfully!",
                      style: GoogleFonts.raleway(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text("You have Successfully registered with us!",
                      style: GoogleFonts.raleway(
                          fontSize: 13,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.45),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: Size(144, 55),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer),
                    onPressed: () {
                      context.pushNamed("login");
                    },
                    child: Text(
                      "Go to Home",
                      style: GoogleFonts.raleway(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
