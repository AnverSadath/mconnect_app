import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/data/models/user_activate_model.dart';
import 'package:mconnect_app/domain/entities/activate_entities.dart';
import 'package:mconnect_app/presentation/logic/provider/user_reg_provider.dart';
import 'package:mconnect_app/presentation/views/registration_success_page/registration_success_page.dart';
import 'package:mconnect_app/presentation/views/user_reg_page/user_reg_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController controller = MobileScannerController();
  bool isError = false;
  String errorMessage = "";

  void _handleBarcode(BarcodeCapture capture) async {
    if (capture.barcodes.isNotEmpty) {
      final String qrcode = capture.barcodes.first.rawValue ?? "";
      if (qrcode.isNotEmpty) {
        print('Scanned QR Code: $qrcode');
        final activateUserProvider =
            Provider.of<UserRegistrationProvider>(context, listen: false);

        ActivateEntities? response =
            await activateUserProvider.activateuser(qrcode);

        if (response != null && response.status == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationSuccess(),
            ),
          );
        } else {
          setState(() {
            isError = true;
            errorMessage = response?.message ?? 'Activation failed.';
          });
          //   Delay to show the error message for a few seconds before resetting
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isError = false;
              errorMessage = "";
            });
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FC),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Center(
            child: Text("Scan QR Code",
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF3D3E8A))),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28))),
          height: MediaQuery.of(context).size.height * 0.875,
          width: double.infinity,
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(left: 70, top: 60),
              child: Text(
                "Scan the QR code below to register",
                style:
                    GoogleFonts.raleway(fontSize: 15, color: Color(0xFF98A6BE)),
              ),
            ),
            Positioned(
                bottom: 200,
                left: 40,
                child: Text("The QR code will be available for 5 minutes",
                    style: GoogleFonts.raleway(
                        fontSize: 15, color: Color(0xFF98A6BE)))),
            Positioned(
              left: 88,
              top: 192,
              child: Stack(children: [
                Container(
                  height: 220,
                  width: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: MobileScanner(
                        controller: controller, onDetect: _handleBarcode),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 130),
              child: QRScannerOverlay(
                scanAreaSize: Size(250, 250),
                overlayColor: Colors.transparent,
                borderColor: isError ? Colors.red : Color(0xFF00AFEF),
                borderRadius: 30,
              ),
            ),
            if (isError)
              Positioned(
                bottom: 260,
                left: 88,
                child: Text(
                  '${errorMessage} Please try again!',
                  style: GoogleFonts.raleway(fontSize: 12, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
          ]),
        )
      ]),
    );
  }
}
