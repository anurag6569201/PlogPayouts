import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/display_location_cards_data.dart';
import 'package:solution_challenge_app/gloves_detector.dart';
import 'package:solution_challenge_app/mask_detector.dart';
import 'package:solution_challenge_app/reset_page_mask_and_gloves.dart';

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
    // fetchedUid = widget._uid;
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
      body: Container(
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
          ],
        ),
      ),
    );
  }
}
