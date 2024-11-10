import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('ws://34.72.67.6:8089'),
    Uri.parse('ws://pigssh.ddns.net:8089'),
  );
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  String kerdes = "";
  String valasz = "";

  void _sendMessage() {
      _channel = WebSocketChannel.connect(
        //Uri.parse('ws://34.72.67.6:8089'),
        Uri.parse('ws://pigssh.ddns.net:8089'),
      );
      kerdes = "en|${_controller.text}";
      _channel.sink.add(kerdes);
      print("kerdesem ");
      print(kerdes);
      _channel.stream.listen(
              (message) {
            print('Received message: $message');
            setState(() => valasz = '$message');

          });

      setState(() {
        _messages.add({"user": _controller.text});
        _messages.add({"sugo": "Hi! I'm thinking. You will receive your answer soon ..." + valasz});
      });

      _controller.clear();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Support'),
      ),
      body:
      Container(
        color: Colors.tealAccent,
      child: Column(
        children: [

          Container(
            width: 250,
            child: Image.asset("assets/robi.jpeg"),),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'What is your problem? :',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),

          Expanded(
            child:
            Container(
              width: 340,
              color: Colors.white,
              child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message.containsKey("user");

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isUserMessage ? message["user"]! : message["sugo"]!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                );
              },
            ),
          ),
          ),


        ],
      ),
      ),
    );
  }
}

enum SampleItem { HUN, EN, SL }

class PopupMenuExample extends StatefulWidget {
  const PopupMenuExample({super.key});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<PopupMenuExample> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PopupMenuButton')),
      body: Center(
        child: PopupMenuButton<SampleItem>(
          initialValue: selectedItem,
          onSelected: (SampleItem item) {
            setState(() {
              selectedItem = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem<SampleItem>(
              value: SampleItem.HUN,
              child: Text('Item 1'),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.EN,
              child: Text('Item 2'),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.SL,
              child: Text('Item 3'),
            ),
          ],
        ),
      ),
    );
  }
}

