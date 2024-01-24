import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/authenticators/status_screen.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

void checkStatus(BuildContext context) async {
  var fetchedUid = FirebaseAuth.instance.currentUser!.uid;
  final data = await FirebaseFirestore.instance
      .collection('users')
      .doc(fetchedUid)
      .get();

  final fetchedData = data.data();
  // print(fetchedData.data());
  // for (final data in fetchedData) {}
  var ok = fetchedData!['trash_deposited'];

  if (ok == false) {
    final snackBar = SnackBar(
      content: Text('Verification failed.Please Try again!'),
      duration: Duration(seconds: 3), // Optional: Set the duration
    );

    // Find the nearest Scaffold and show the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    final results = Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => statusScreen(fetchedData!['points']),
      ),
    );
  }
}

class _StatusState extends State<Status> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Reward Status',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 5, 134, 10),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // backgroundColor: Theme.of(context).colorScheme.background,
              // padding: EdgeInsets.all(20),
              // margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 400,
              // foregroundDecoration: BoxDecoration(
              //     border: Border.all(color: Colors.greenAccent)),
              child:
                  Image.asset('assets/images/rewards-0-removebg-preview.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                checkStatus(context);
              },
              icon: const Icon(Icons.check),
              label: const Text(
                'Check',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 134, 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
