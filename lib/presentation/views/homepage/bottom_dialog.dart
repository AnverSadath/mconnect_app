import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomDialog extends StatefulWidget {
  const BottomDialog({Key? key}) : super(key: key);

  @override
  State<BottomDialog> createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: 200,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.headset_mic_rounded,
                    color: Color(0xFFF3D3E8A), size: 15),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'New Support Request',
                    style: GoogleFonts.raleway(
                        fontSize: 14, color: Color(0XFFF707070)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.edit_note_sharp,
                  color: Color(0xFFF3D3E8A),
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'New Onsite Request',
                    style: GoogleFonts.raleway(
                        fontSize: 14, color: Color(0XFFF707070)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: Color(0xFFF3D3E8A),
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Call Service Coordinator',
                    style: GoogleFonts.raleway(
                        fontSize: 14, color: Color(0XFFF707070)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
