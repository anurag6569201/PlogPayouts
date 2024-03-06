import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videosScreen extends StatefulWidget {
  videosScreen({super.key});

  @override
  State<videosScreen> createState() => _videosScreenState();
}

class _videosScreenState extends State<videosScreen> {
  YoutubePlayerController _ytcontroller =
      YoutubePlayerController(initialVideoId: 'Dn2QWmRpGrs', flags: YoutubePlayerFlags(autoPlay : false));

  YoutubePlayerController _ytcontroller2 =
      YoutubePlayerController(initialVideoId: 'fU7S5YPEcQk',flags: YoutubePlayerFlags(autoPlay : false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Demonstartion Videos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 134, 10),
            ),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: _addItem,
          //     icon: const Icon(Icons.add),
          //   ),
          // ],
        ),
        body: Container(
          child: Column(
            children: [
              YoutubePlayer(
                controller: _ytcontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              YoutubePlayer(
                controller: _ytcontroller2,
              ),
            ],
          ),
        ));
  }
}
