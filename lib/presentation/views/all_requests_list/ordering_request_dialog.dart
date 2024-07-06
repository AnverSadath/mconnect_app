import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderingRequest extends StatelessWidget {
  const OrderingRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 172,
        width: 200,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.event_note,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Search by Date',
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: Color(0XFFF707070)),
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
                  Icons.check_circle_outline_outlined,
                  color: Color(0xFF6AB26A),
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Completed',
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: Color(0XFFF707070)),
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
                  Icons.back_hand_rounded,
                  color: Color(0XFFFEC3333),
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'On Hold',
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: Color(0XFFF707070)),
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
                  Icons.timelapse_rounded,
                  color: Color(0XFFCEA851),
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'On Hold',
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: Color(0XFFF707070)),
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
                  Icons.close_rounded,
                  color: Color(0xFF8F8F8F),
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Cancelled',
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: Color(0XFFF707070)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
