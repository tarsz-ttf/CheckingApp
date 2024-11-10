// issues_screen.dart
import 'package:flutter/material.dart';
// issues_screen.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Video controller inicializálása a hálózati URL-lel
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videó Lejátszás'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}



class IssuesScreen extends StatefulWidget {
  @override
  _IssuesScreenState createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // Minta videó lista (ide jöhetnek a tutorial videók URL-jei, címek)
  final List<Map<String, String>> _videos = [
    {
      'title': 'Check-in probléma megoldása',
      'thumbnail': 'https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg',
      'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    },
    {
      'title': 'Check-out tippek és trükkök',
      'thumbnail': 'https://img.youtube.com/vi/3JZ_D3ELwOQ/0.jpg',
      'url': 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ',
    },
    {
      'title': 'Check-in probléma megoldása',
      'thumbnail': 'https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg',
      'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    },
    {
      'title': 'Check-out tippek és trükkök',
      'thumbnail': 'https://img.youtube.com/vi/3JZ_D3ELwOQ/0.jpg',
      'url': 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ',
    },
    {
      'title': 'Check-in probléma megoldása',
      'thumbnail': 'https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg',
      'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    },
    {
      'title': 'Check-out tippek és trükkök',
      'thumbnail': 'https://img.youtube.com/vi/3JZ_D3ELwOQ/0.jpg',
      'url': 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Szűrés a keresési feltétel alapján
    List<Map<String, String>> filteredVideos = _videos
        .where((video) =>
        video['title']!.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Felmerülő Problémák Megoldása'),
      ),
      body: Column(
        children: [
          // Keresősáv
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Keresés problémák között...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              },
            ),
          ),
          // Görgethető videó lista
          Expanded(
            child: ListView.builder(
              itemCount: filteredVideos.length,
              itemBuilder: (context, index) {
                final video = filteredVideos[index];
                return ListTile(
                  leading: Image.network(
                    video['thumbnail']!,
                    width: 100,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                  title: Text(video['title']!),
                  onTap: () {
                    // URL megnyitása (például külső böngészőben)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoPlayerScreen(videoUrl: video['url']!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



