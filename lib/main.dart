import 'package:checkingapp/qr_screen.dart';
import 'package:flutter/material.dart';

import 'IssuesScreen.dart';
import 'cleaning_schedule.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Checking App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = "Adam";
  String IDnum = "NH027735";
  String szuldate = "1992-11-01";
  final String kod = 'https://example.com'; // QR-kóddá alakítandó szöveg vagy URL
  final Map<String, String> nyelvMap = {
    "hu": "assets/flag_hun.png",
  };
  String flag = "assets/flag_hun.png";
  final List<String> nyelvek = ['hu'];
  String selectedOption = 'hu';

  int myc = 0;
  String _selectedLocaleId = "HUN";

  void _incrementCounter() {
    setState(() {
      myc++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading:ElevatedButton(onPressed: (){
          print("menu pressed");
        }, child: Icon(Icons.menu)),

        title: Text(widget.title),

        actions: <Widget>[
          ElevatedButton(onPressed: (){
            print("Settings pressed");
          }, child: Icon(Icons.settings))
        ],
        
      ),
      
      
      
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[



            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScreen(kod: kod),
                    ),
                  );
                },
                child: Text("Check In")),),

            SizedBox(height: 50),

            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRScreen(kod: kod),
                      ),
                    );
                  },
                child: Text("Check Out")),),

            SizedBox(height: 50),

            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                onPressed: () {

                },
                child: Text("Settings")),),

            SizedBox(height: 50),

            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IssuesScreen(),
                      ),
                    );
                  },
                  child: Text("Help in Issues")),),

            SizedBox(height: 50),

            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CleaningScheduleScreen(),
                      ),
                    );
                  },
                  child: Text("Schedule Cleaing")),),



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.help),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
