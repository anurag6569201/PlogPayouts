import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Thank your for your time!'),
      ),
      body: Container(
        alignment: Alignment(0, 0.25),
        padding: EdgeInsets.all(70),
        margin: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
      ),
    );
  }
}
