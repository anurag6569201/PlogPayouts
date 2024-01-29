//qr_code.dart

// import 'package:blog/QR/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final qrKey = GlobalKey();
  // String qrData = 'Hello! Buddy';
  String? _scanCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QR Code Scanner",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 5, 134, 10),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(80),
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _scanCode == null
                ? SizedBox()
                : SelectableText(
                    '''Scanned Code :

                    $_scanCode''',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 134, 10),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                scanQR();
              },
              child: const Text("Scan Code"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanCode = barcodeScanRes;
    });
  }
}
