import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/auth.dart';
import 'package:solution_challenge_app/previews/preview_home.dart';

class resetValueGlovesAndMask extends StatefulWidget {
  resetValueGlovesAndMask(this._uid, {super.key});
  String _uid;

  @override
  State<resetValueGlovesAndMask> createState() =>
      _resetValueGlovesAndMaskState();
}

class _resetValueGlovesAndMaskState extends State<resetValueGlovesAndMask> {
  var fetchedUid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedUid = widget._uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank your for your time!',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 125, 67))),
      ),
      body: Container(
        alignment: Alignment(0, 0.25),
        padding: EdgeInsets.all(70),
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    // backgroundColor: Theme.of(context).colorScheme.background,
                    // padding: EdgeInsets.all(20),
                    // margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 400,
                    // foregroundDecoration: BoxDecoration(
                    //     border: Border.all(color: Colors.greenAccent)),
                    child: Image.asset('assets/images/exit.jpg')),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(fetchedUid)
                        .update({
                      // 'username': _enteredUserName,
                      // 'email': _enteredEmail,
                      'gloves_ok': false,
                      'mask_ok': false
                    });
                    //   FirebaseFirestore.instance
                    //       .collection('users')
                    //       .doc(fetchedUid)
                    //       .update({
                    //     // 'username': _enteredUserName,
                    //     // 'email': _enteredEmail,

                    //   });

                    FirebaseAuth.instance.signOut();

                    ScaffoldMessenger.of(context).clearSnackBars();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You have been logged out succesfully!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_box),
                  label: const Text('Please check before exit'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
