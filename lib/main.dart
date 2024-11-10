import 'package:checkingapp/qr_screen.dart';
import 'package:checkingapp/qr_screen2.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'ChatScreen.dart';
import 'IssuesScreen.dart';
import 'UserInputScreen.dart';
import 'cleaning_schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Adatok mentése
Future<void> saveUserData(String name, String IDnum, String szuldate) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
  await prefs.setString('IDnum', IDnum);
  await prefs.setString('szuldate', szuldate);
}

// Adatok betöltése
Future<Map<String, String?>> loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('name');
  String? IDnum = prefs.getString('IDnum');
  String? szuldate = prefs.getString('szuldate');

  return {
    'name': name,
    'IDnum': IDnum,
    'szuldate': szuldate,
  };
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHECK-kIng',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CHECK-kINg'),
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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(_selectedIndex==2){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserInputScreen()),
      );
    }
    if(_selectedIndex==0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserInputScreen()),
      );
    }
  }
  String name = "Adam Nagy";
  String IDnum = "NH027735";
  String szuldate = "01-11-1992";
  final String kod = 'https://example.com'; // QR-kóddá alakítandó szöveg vagy URL
  final Map<String, String> nyelvMap = {
    "hu": "assets/flag_hun.png",
  };
  String flag = "assets/flag_hun.png";
  final List<String> nyelvek = ['hu'];
  String selectedOption = 'hu';

  int myc = 0;
  String _selectedLocaleId = "HUN";

  YoutubePlayerController _controller = YoutubePlayerController(
    //initialVideoId: 'rhMnIXkMI94',
    initialVideoId: 'c_EAnxmEp3E',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  //double _volume = 100;
  //bool _muted = false;
  bool _isPlayerReady = false;
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  void getUserData() async {
    Map<String, String?> userData = await loadUserData();
    print("Name: ${userData['name']}");
    print("ID Number: ${userData['IDnum']}");
    print("Birth Date: ${userData['szuldate']}");
  }


  _MyHomePageState() {
    saveUserData(name,IDnum,szuldate);
    //getUserData();
  }

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
      ),
    );
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
      
      
      
      body: SingleChildScrollView(
        child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[



            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(listener);
              },
            ),

            SizedBox(height: 20),

            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScreen(kod: kod, name: name, id: IDnum, date: szuldate),
                    ),
                  );
                },
                child: Text("Check In")),),

            SizedBox(height: 20),

            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRScreen2(kod: kod, name: name, id: IDnum, date: szuldate),
                      ),
                    );
                  },
                child: Text("Check Out")),),

            SizedBox(height: 20),

            Container(
              width: 250,
              height: 75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserInputScreen()),
                    );
                  },
                child: Text("Settings")),),

            SizedBox(height: 20),

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

            SizedBox(height: 20),

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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Language',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.help),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
