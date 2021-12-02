import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QrScannerText extends StatelessWidget {
  final data ;
  QrScannerText({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (data != null)
            ? Text(
            'Barcode Type: ${describeEnum(data!.format)}   Data: ${data!.code}')
            : Text('Scan a code'),
      ),
      );
  }
}

