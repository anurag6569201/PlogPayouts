import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/coupons.dart';
import 'package:solution_challenge_app/redeemed_code_screen_details.dart';
import 'package:solution_challenge_app/rewards_items_details.dart';

class redeemedCodesScreen extends StatefulWidget {
  redeemedCodesScreen({super.key});

  @override
  State<redeemedCodesScreen> createState() => _redeemedCodesScreenState();
}

class _redeemedCodesScreenState extends State<redeemedCodesScreen> {
  var collectedCodesData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collectedCodesData = [];
    collectedDataRetrieved();
  }

  void collectedDataRetrieved() async {
    final uuid = FirebaseAuth.instance.currentUser!.uid;

    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection('redeemed_codes')
        .doc('List')
        .get();

    final fetchedData = data.data();
    // var fetchedDataList = [];
    final temp = fetchedData!.entries;
    final codes = [];
    for (final points in temp) {
      codes.add(points.value);
    }
    print(codes);
    setState(() {
      collectedCodesData = codes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Redeemable Codes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 134, 10),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: collectedCodesData.length,
          itemBuilder: (ctx, index) => redeemedCodesDetailsScreen(
            collectedCodesData[index],
          ),
        ));
  }
}
