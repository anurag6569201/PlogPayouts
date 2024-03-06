import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _ytcontroller = YoutubePlayerController(
        initialVideoId: 'Dn2QWmRpGrs',
        flags: YoutubePlayerFlags(autoPlay: false));

    YoutubePlayerController _ytcontroller2 = YoutubePlayerController(
        initialVideoId: 'fU7S5YPEcQk',
        flags: YoutubePlayerFlags(autoPlay: false));

    YoutubePlayerController _ytcontroller3 = YoutubePlayerController(
        initialVideoId: 'KV4nU_APFjQ',
        flags: YoutubePlayerFlags(autoPlay: false));

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Welcome to Demonstration Page',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 125, 67)),
          ),
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
                controller: _ytcontroller3,
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
