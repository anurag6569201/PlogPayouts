import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/authenticators/authenticator_drawer.dart';
import 'package:solution_challenge_app/authenticators/reward.dart';
import 'package:solution_challenge_app/authenticators/scan.dart';

import 'package:solution_challenge_app/data/display_location_cards_data.dart';
import 'package:solution_challenge_app/gloves_detector.dart';
import 'package:solution_challenge_app/main_drawer.dart';
import 'package:solution_challenge_app/mask_detector.dart';
import 'package:solution_challenge_app/reset_page_mask_and_gloves.dart';

class homeAuthenticator extends StatefulWidget {
  homeAuthenticator(this._uid, {super.key});
  String _uid;
  @override
  State<homeAuthenticator> createState() => _homeAuthenticatorState();
}

class _homeAuthenticatorState extends State<homeAuthenticator> {
  // var fetchedUid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchedUid = widget._uid;
  }

  void _setScreen(String identifier) async {
    // if (identifier == 'Status') {
    //   Navigator.of(context).pop();
    //   final results = await Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (ctx) => collectedTrashStatus(),
    //     ),
    //   );
    // }

    if (identifier == 'Scan QR Code') {
      Navigator.of(context).pop();
      final results = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => QRScreen(),
        ),
      );
    }

    if (identifier == 'Rewards Calculation') {
      Navigator.of(context).pop();
      final results = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => reward(),
        ),
      );
    }
  }

  final fetchedUid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerAuthneticator(_setScreen, fetchedUid),
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
              onPressed: () {},
              icon: const Icon(Icons.add_to_photos),
              label: const Text('Dunno!'),
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
