import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/gloves_detector.dart';
import 'package:solution_challenge_app/mask_detector.dart';
import 'package:solution_challenge_app/ranking.dart';
import 'package:solution_challenge_app/ranking_details.dart';
import 'package:solution_challenge_app/reset_page_mask_and_gloves.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home(this._uid, {super.key});
  String _uid;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var fetchedUid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // temp();

    // fetchedUid = widget._uid;
  }

  void temp() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid.toString();

    final url = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/central-database.json');

    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': 'Akanksha Avenue',
          'latitude': 20.293753980962897,
          'longitude': 85.74939495330412,
          'image_url':
              'https://firebasestorage.googleapis.com/v0/b/solution-challenge-app-409f6.appspot.com/o/location-images%2FtRx3M26AsIasYWVQl7tqxpvdVqz1%2FAkanksha%20Avenue1eec77a4-532d-61c0-90eb-7598b7596b5e.jpg?alt=media&token=af431313-7395-429d-9709-aa2f9b38fc8c',
          'color': 4294940672,
          'Id': 4,
        },
      ),
    );
  }

  final fetchedUid = FirebaseAuth.instance.currentUser!.uid.toString();

  void _MaskandGloveScreen() async {
    // if (identifier == 'filters') {
    // Navigator.of(context).pop();
    final mask_result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => maskDetector(fetchedUid),
      ),
    );

    final gloves_result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => glovesDetector(fetchedUid),
      ),
    );
  }

  void _ranksScreen() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ranking(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => resetValueGlovesAndMask(fetchedUid),
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        title: const Text(
          'Welcome to PlogPayouts!',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 125, 67)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_2.jpg'),
              ElevatedButton.icon(
                onPressed: _MaskandGloveScreen,
                icon: const Icon(Icons.add_to_photos),
                label: const Text('Health Check First!'),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/winner.jpg'),
              ElevatedButton.icon(
                onPressed: _ranksScreen,
                icon: const Icon(Icons.add_to_photos),
                label: const Text('Ranks!'),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 40,
              ),
              Card(
                shadowColor: Colors.amber,
                elevation: 8,
                color: Color.fromARGB(255, 77, 231, 156),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "Our Aim",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // margin: const EdgeInsets.all(12.0),
              Card(
                shadowColor: Colors.amber,
                elevation: 8,
                color: Color.fromARGB(255, 77, 231, 156),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'We aim to provide a not only an idea but also a solution to bring about a solid change in the way we think about the ',
                        ),
                        TextSpan(
                          text: 'PRE ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'and ',
                        ),
                        TextSpan(
                          text: 'POST ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'garbage collection process so as to harbour a more cleaner and greener environment.',
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   "We aim to provide a not only an idea but also a solution to bring about a solid change in the way we think about the PRE and **POST** garbage collection process so as to harbour a more cleaner and greener for generations to come.",
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white),
                  //   softWrap: true,
                  //   textAlign: TextAlign.center,
                  // ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Card(
                shadowColor: Colors.amber,
                elevation: 8,
                color: Color.fromARGB(255, 77, 231, 156),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "Our Targets",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Sustainable_Development_Goal_11SustainableCities.svg/1200px-Sustainable_Development_Goal_11SustainableCities.svg.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Sustainable_Development_Goal_03GoodHealth.svg/1200px-Sustainable_Development_Goal_03GoodHealth.svg.png',
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://hlpf.un.org/sites/default/files/2023-06/SDG%208.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Card(
                shadowColor: Colors.amber,
                elevation: 8,
                color: Color.fromARGB(255, 77, 231, 156),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "As a part of",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,q_auto:good/v1/gcs/platform-data-dsc/events/Copy%20of%20DSC-Website-EventThumbnail_Mez18gO.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
