import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/coupons.dart';
import 'package:solution_challenge_app/rewards_items_details.dart';

class Store extends StatefulWidget {
  Store(this.fetchedPoints, {super.key});
  int fetchedPoints;

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedPointsnew = 0;
    fetchPoints();
  }

  var fetchedPointsnew;
  void fetchPoints() async {
    var pointsTemp;
    final uuid = FirebaseAuth.instance.currentUser!.uid;
    final data =
        await FirebaseFirestore.instance.collection('users').doc(uuid).get();

    pointsTemp = data.data()!['points'];

    setState(() {
      fetchedPointsnew = pointsTemp;
    });
  }

  void _showPointsDialogBox(BuildContext context) {
    String rewarded_points = widget.fetchedPoints.toString();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              scrollable: true,
              title: const Text(
                'Your PlogPoints',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 134, 10),
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                children: [
                  Text(
                    fetchedPointsnew.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 134, 10),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Image.asset(),
          TextButton.icon(
            onPressed: () {
              _showPointsDialogBox(context);
            },
            icon: const Icon(
              Icons.monetization_on,
              size: 20,
            ),
            label: const Text(
              'PlogPoints',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 134, 10),
              ),
            ),
          ),
        ],
        title: const Text(
          'Welcome to the Store!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 5, 134, 10),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (ctx, index) => rewardsDetails(
          dummyData[index],
        ),
      ),
    );
  }
}
