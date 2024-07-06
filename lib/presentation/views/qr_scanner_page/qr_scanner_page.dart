import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/domain/entities/activate_entities.dart';
import 'package:mconnect_app/presentation/logic/provider/user_reg_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController controller = MobileScannerController();
  bool isError = false;
  String errorMessage = "";
  bool isScanning = true;

  void _handleBarcode(BarcodeCapture capture) async {
    if (capture.barcodes.isNotEmpty && isScanning) {
      final String qrcode = capture.barcodes.first.rawValue ?? "";

      if (qrcode.isNotEmpty) {
        print('Scanned QR Code: $qrcode');
        isScanning = false;

        final activateUserProvider =
            Provider.of<UserRegistrationProvider>(context, listen: false);

        ActivateEntities? response =
            await activateUserProvider.activateuser(qrcode);

        if (response != null && response.status == 1) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setBool("isScanningComplete", true);
          context.pushNamed("regsuccess");
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: Text("Scan QR Code",
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary)),
            ),
          ),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28))),
            height: MediaQuery.of(context).size.height * 0.875,
            width: double.infinity,
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 70, top: 60),
                child: Text(
                  "Scan the QR code below to register",
                  style: GoogleFonts.raleway(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
              Positioned(
                  bottom: 200,
                  left: 40,
                  child: Text("The QR code will be available for 5 minutes",
                      style: GoogleFonts.raleway(
                          fontSize: 15,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer))),
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
                  borderColor: isError
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onSurface,
                  borderRadius: 30,
                ),
              ),
              if (isError)
                Positioned(
                  bottom: 260,
                  left: 88,
                  child: Text(
                    '${errorMessage} Please try again!',
                    style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSecondary),
                    textAlign: TextAlign.center,
                  ),
                ),
            ]),
          )
        ]),
      ),
    );
  }
}
