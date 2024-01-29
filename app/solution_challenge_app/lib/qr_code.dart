//qr_code.dart

// import 'package:blog/QR/scan_qr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGeneratorScreen extends StatefulWidget {
  const QRCodeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeGeneratorScreen> createState() => _QRCodeGeneratorScreenState();
}

class _QRCodeGeneratorScreenState extends State<QRCodeGeneratorScreen> {
  final qrKey = GlobalKey();
  var qrData;
  // String? _scanCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qrData = "";
    _loadEmail();
  }

  void _loadEmail() {
    var loadData;

    // final userUid = FirebaseAuth.instance.currentUser!.uid.toString();

    loadData = FirebaseAuth.instance.currentUser!.uid;
    print(loadData);
    setState(() {
      qrData = loadData;
    });
  }

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
            QrImageView(
              data: qrData,
              size: 250,
              // backgroundColor: Colors.red,
              gapless: false,
              // eyeStyle: const QrEyeStyle(
              //     color: Colors.green, eyeShape: QrEyeShape.circle),
              version: QrVersions.auto,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
