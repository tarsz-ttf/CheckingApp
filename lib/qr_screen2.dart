// qr_screen.dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen2 extends StatelessWidget {
  final String kod;
  final String name;
  final String id;
  final String date;

  QRScreen2({required this.kod, required this.name, required this.id, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check-out By QR Code'),
      ),
      body:
      Center(
        child:
        Container(
          width: 310,
          color: Colors.tealAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
              width: 250,
            color: Colors.blueGrey,
                child: Row( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text('Mutasd Meg ezt a QR kodot \n a KIOSK-nak a check-IN-hez \n vagy a recepciosnak',style:TextStyle(color: Colors.white)),],)
            ),
            SizedBox(height: 70),
            Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: QrImageView(
            data: kod,           // A QR kódhoz kódolandó szöveg vagy URL
            version: QrVersions.auto,
            size: 200.0,
           ),
           ),
            SizedBox(height: 70),
            Container(
              width: 250,
                height: 100,
              color: Colors.blueGrey,
              child:Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('Name of user: ',style:TextStyle(color: Colors.white,fontSize: 18)),Text(name,style:TextStyle(color: Colors.white,fontSize: 18))]),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('ID number: ',style:TextStyle(color: Colors.white,fontSize: 18)),Text(id,style:TextStyle(color: Colors.white,fontSize: 18))],),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('Date of birth: ',style:TextStyle(color: Colors.white,fontSize: 18)),Text(date,style:TextStyle(color: Colors.white,fontSize: 18))],)
              ],)
            ),
          ],
        ),
        ),
      ),
    );
  }
}
