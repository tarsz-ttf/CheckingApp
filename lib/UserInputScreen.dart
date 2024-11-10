import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:image_picker/image_picker.dart';

class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  String _extractedText = '';
  late WebSocketChannel _channel;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('IDnum', _idController.text);
    await prefs.setString('szuldate', _birthdateController.text);


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Adatok elmentve!')),
    );

    // send to server
    _channel = WebSocketChannel.connect(
    //Uri.parse('ws://34.72.67.6:8089'),
          Uri.parse('ws://35.226.75.104:8089'),
        );
        _channel.sink.add("mentes|${_nameController.text},${_idController.text},${ _birthdateController.text}") ;
  }

  void mezoket_feltolteni(String _extractedText){
    setState(() {
      _idController.text = "NH027735";
    });
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _frontImage;
  XFile? _backImage;

  Future<void> _pickFrontImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _frontImage = pickedFile;
    });

    if (_frontImage != null) {
      // Szöveg kinyerése az előlap képéből
      String text = await FlutterTesseractOcr.extractText(_frontImage!.path, language: 'kor+eng',
          args: {
            "psm": "4",
            "preserve_interword_spaces": "1",
          });

      setState(() {
        _extractedText = text;
        print("_extractedText");
        print(_extractedText);
        mezoket_feltolteni(_extractedText);
      });
    }
  }

  Future<void> _pickBackImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _backImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Data Here'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID number'),
            ),
            TextField(
              controller: _birthdateController,
              decoration: InputDecoration(labelText: 'Birth date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUserData,
              child: Text('Save'),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black, width: 4),
              ),
              child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickFrontImage,
                  child: Text('ID Card front cover'),
                ),
              ],
            ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black, width: 4),
              ),
              child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    ElevatedButton(
                      onPressed: _pickBackImage,
                      child: Text('ID Card back cover'),
                    ),
              ],
            ),
            ),
            SizedBox(height: 20),
            if (_frontImage != null)
              Text('Előlap fotózva: ${_frontImage!.path}'),
            if (_backImage != null)
              Text('Hátlap fotózva: ${_backImage!.path}'),
          ],
        ),
      ),
    );
  }
}

