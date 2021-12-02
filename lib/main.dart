import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/Show_Qr_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: QrScanner(),
    );
  }
}

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {

  GlobalKey qrkey = GlobalKey();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    }
  }

  Barcode? result;
  var qrText ="";

  QRViewController? controller;

  void  _onQRViewCreated(QRViewController controller ) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData){
      result = scanData;
      controller.pauseCamera();
    //   final String qrCode = qrData.code;
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => SecondPage(
    //             qrCode: '$qrCode',
    //           ))).then((value) => qrViewController.resumeCamera());
    // });
      Navigator.push(context, MaterialPageRoute(builder: (context) => QrScannerText(
          data: result,
        ),),).then((value) => controller.resumeCamera());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 5,
              child: QRView(
                key: qrkey,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                   borderWidth: 10,
                  cutOutSize:MediaQuery.of(context).size.width * 0.8,
                ),
                onQRViewCreated:_onQRViewCreated,
              ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}





