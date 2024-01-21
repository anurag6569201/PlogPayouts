import 'package:cloud_firestore/cloud_firestore.dart';
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
  var fetchedUid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedUid = widget._uid;
  }
  // var _usernameRetrieved = '';

  // void _getUsername() async {
  //   final user = await FirebaseAuth.instance.currentUser;

  //   final _userdata = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .get();

  //   _usernameRetrieved = _userdata.data()!['username'];
  // }

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
    // Navigator.of(context).pop();
    // } else {
    // Navigator.of(context).pop();

//Maybe add a Snackbar?
    // ScaffoldMessenger.of(context).clearSnackBars();

    // if (mask_result == true && gloves_result == true) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Security Check Successfull'),
    //     ),
    //   );
    // } else {
    //   print(mask_result);
    //   print(gloves_result);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please go through the check again'),
    //     ),
    //   );
    // }
  }

  // List<Category> _updatedAvailableCatgories = [];
  // void _storeData() async {
  //   // deleteCollection('locations');

  //   var count = 0;
  //   for (final category in availableCategories) {
  //     await FirebaseFirestore.instance
  //         .collection('locations')
  //         .doc('L${count}')
  //         .set(
  //       {
  //         'id': category.id,
  //         'title': category.title,
  //         'color': category.color.value,
  //         'coordinates': category.coordinates,
  //       },
  //     );
  //     count = count + 1;
  //   }

  //   // setState(() {
  //   //   _updatedAvailableCatgories = availableCategories;
  //   // });
  //   for (final category in availableCategories) {
  //     print(category.color);
  //     print(category.coordinates);
  //     print(category.id);
  //     print(category.title);
  //   }
  //   // print(availableCategories.length);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(fetchedUid)
              //     .update({
              //   // 'username': _enteredUserName,
              //   // 'email': _enteredEmail,
              //   'gloves_ok': false
              // });
              // FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(fetchedUid)
              //     .update({
              //   // 'username': _enteredUserName,
              //   // 'email': _enteredEmail,
              //   'mask_ok': false
              // });

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => resetValueGlovesAndMask(fetchedUid),
                ),
              );

              // FirebaseAuth.instance.signOut();

              // Navigator.of(context).pop();
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
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Colors.orangeAccent, Colors.greenAccent],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight),
        // ),
        padding: const EdgeInsets.all(40),
        // margin: const EdgeInsets.all(80),
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //   padding: EdgeInsets.all(20),
            // ),
            ElevatedButton.icon(
              onPressed: _MaskandGloveScreen,
              icon: const Icon(Icons.add_to_photos),
              label: const Text('Health Check First!'),
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer),
            ),

            // ElevatedButton.icon(
            //   onPressed: () {
            //     // deleteCollection('locations');
            //     _storeData();
            //   },
            //   icon: const Icon(Icons.add_to_photos),
            //   label: const Text('Load Data'),
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor:
            //           Theme.of(context).colorScheme.primaryContainer),
            // ),
          ],
        ),
      ),
    );
  }
}
