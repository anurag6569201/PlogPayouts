import 'package:flutter/material.dart';
import 'package:solution_challenge_app/authenticators/garbage_images_details.dart';

import 'package:solution_challenge_app/redeemed_code_screen_details.dart';

class garbageImages extends StatefulWidget {
  garbageImages(this.urls, {super.key});
  var urls;

  @override
  State<garbageImages> createState() => _garbageImagesState();
}

class _garbageImagesState extends State<garbageImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Collected Garbage by Candidate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 134, 10),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.urls.length,
          itemBuilder: (ctx, index) => garbageImagesDetailsScreen(
            widget.urls[index],
          ),
        ));
  }
}
