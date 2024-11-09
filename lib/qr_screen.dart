// qr_screen.dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  final String kod;

  QRScreen({required this.kod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check-in By QR Kód'),
      ),
      body:
      Center(
        child:
        Container(
          width: 300,
          color: Colors.tealAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
            color: Colors.blueGrey,
                child: Text('Mutasd Meg ezt a QR kodot a KIOSK-nak a check-IN-hez vagy a recepciosnak'),
            ),
            SizedBox(height: 70),
            Container(
          color: Colors.blue,
          padding: EdgeInsets.all(20.0),
          child: QrImageView(
            data: kod,           // A QR kódhoz kódolandó szöveg vagy URL
            version: QrVersions.auto,
            size: 200.0,
           ),
           ),
          ],
        ),
        ),
      ),
    );
  }
}
