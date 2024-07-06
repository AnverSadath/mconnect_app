import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/presentation/views/all_requests_list/ordering_request_dialog.dart';

class AllRequestsList extends StatefulWidget {
  const AllRequestsList({super.key});

  @override
  State<AllRequestsList> createState() => _AllRequestsListState();
}

class _AllRequestsListState extends State<AllRequestsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.080,
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 170),
                    child: Text(
                      "Status",
                      style: GoogleFonts.raleway(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_rounded,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ))
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0100),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.290,
                                MediaQuery.of(context).size.height * 0.035)),
                        onPressed: () {},
                        child: Text("Support Requests",
                            style: GoogleFonts.raleway(
                                fontSize: 12,
                                color:
                                    Theme.of(context).colorScheme.onPrimary))),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.020),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.290,
                              MediaQuery.of(context).size.height * 0.035)),
                      onPressed: () {},
                      child: Text("Onsite Requests",
                          style: GoogleFonts.raleway(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary))),
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0200),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.71,
                      height: MediaQuery.of(context).size.height * 0.063,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).colorScheme.onPrimary),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.raleway(
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFA9B5C9),
                            fontSize: 16,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            size: 24,
                            color: Color(0xFF707070),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.035),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.only(top: 230),
                          child: FluidDialog(
                            defaultDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            rootPage: FluidDialogPage(
                              alignment: Alignment.topRight,
                              builder: (context) =>
                                  SizedBox(child: OrderingRequest()),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(15)),
                      height: MediaQuery.of(context).size.height * 0.060,
                      width: MediaQuery.of(context).size.width * 0.14,
                      child: Center(
                          child: Icon(
                        Icons.tune_outlined,
                        color: Color(0xFF707070),
                        size: 25,
                      )),
                    ),
                  )
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0200),
                Container(
                    width: MediaQuery.of(context).size.width * double.infinity,
                    height: MediaQuery.of(context).size.height * 0.615,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28))),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.500,
                      width:
                          MediaQuery.of(context).size.width * double.infinity,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          // if (index == leadProvider.leads.length) {
                          //   return Center(child: CircularProgressIndicator());
                          // }
                          //    final lead = leadProvider.leads[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              children: [
                                Row(children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFEAEAEA),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Text(
                                            "data",
                                            style: GoogleFonts.raleway(
                                                color: Color(0xFFF2F52A2),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  Color(0XfffD1D1D1),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                size: 11,
                                              ),
                                            ),
                                          )
                                        ]),
                                        Text(
                                          'Contact:',
                                          style: TextStyle(
                                              color: Color(0xFFF98A6BE),
                                              fontSize:
                                                  11 // Set the color of 'Contact: ' to red
                                              ),
                                        ),
                                        Text(
                                          'Status: ',
                                          style: TextStyle(
                                              color: Color(0XFFF98A6BE),
                                              fontSize:
                                                  11 // Set the color of the status text to yellow
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  color: Color(0xFFFD1D1D1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
