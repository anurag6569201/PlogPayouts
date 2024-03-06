import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainDrawerAuthneticator extends StatefulWidget {
  MainDrawerAuthneticator(this.selectedScreen, this.uid, {super.key});
  final void Function(String identifier) selectedScreen;
  String uid;

  @override
  State<MainDrawerAuthneticator> createState() =>
      _MainDrawerAuthenticatorState();
}

class _MainDrawerAuthenticatorState extends State<MainDrawerAuthneticator> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName = 'Welcome';

    profileImageUrl = '';
    resultMakandGloves();
    ok = false;
  }

  var userName;

  var profileImageUrl;
  var ok;

  Future<String> _getUserName(String uid) async {
    var _userData = await FirebaseFirestore.instance
        .collection('authenticators')
        .doc(uid)
        .get();

    userName = _userData.data()!['username'];
    return userName;
    // print(userName);
  }

  Future<String> _getProfileImageUrl(String uid) async {
    var _userData = await FirebaseFirestore.instance
        .collection('authenticators')
        .doc(uid)
        .get();

    profileImageUrl = _userData.data()!['image_url'];
    // gloves_ok = _userData.data()!['gloves_ok'];
    return profileImageUrl;
    // print(userName);
  }

  void resultMakandGloves() async {
    var isOk = false;
    var maskresult;
    var glovesresult;
    var uuid = FirebaseAuth.instance.currentUser!.uid;

    var _userData = await FirebaseFirestore.instance
        .collection('authenticators')
        .doc(uuid)
        .get();

    maskresult = _userData.data()!['mask_ok'];
    glovesresult = _userData.data()!['gloves_ok'];
    if (maskresult == true && glovesresult == true) {
      isOk = true;
    }
    setState(() {
      ok = isOk;
    });
  }

  void showPopUp(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Optional duration
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String _uid = widget.uid;
    // userName = _getUserName(_uid);
    // print(userName);
    _getUserName(_uid).then((String result) {
      setState(() {
        userName = result;
      });
    });

    _getProfileImageUrl(_uid).then((String result) {
      setState(() {
        profileImageUrl = result;
      });
    });

    print(userName);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(profileImageUrl),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 13,
                ),
                Text(
                  "${userName}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.location_city,
          //     size: 26,
          //     color: Theme.of(context).colorScheme.onBackground,
          //   ),
          //   title: Text(
          //     'Status',
          //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //           color: Theme.of(context).colorScheme.onBackground,
          //           fontSize: 24,
          //         ),
          //   ),
          //   onTap: () {
          //     //function here

          //     widget.selectedScreen('Status');
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.location_city,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'QR Code Scanner',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              //function here

              (ok == true)
                  ? widget.selectedScreen('Scan QR Code')
                  : showPopUp(
                      context, "Please go through Health Check-Up first!");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.location_city,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Rewards Calculation',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              //function here

              (ok == true)
                  ? widget.selectedScreen('Rewards Calculation')
                  : showPopUp(
                      context, "Please go through Health Check-Up first!");
            },
          ),

          ListTile(
            leading: Icon(
              Icons.location_city,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Demostration Videos',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              //function here

              widget.selectedScreen('Videos');
            },
          ),
        ],
      ),
    );
  }
}
