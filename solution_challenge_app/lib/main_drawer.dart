import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer(this.selectedScreen, this.uid, {super.key});
  final void Function(String identifier) selectedScreen;
  String uid;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName = 'Welcome';
    mask_ok = false;
    gloves_ok = false;
    profileImageUrl = '';
  }

  var userName;
  var mask_ok;
  var gloves_ok;
  var profileImageUrl;

  Future<String> _getUserName(String uid) async {
    var _userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    userName = _userData.data()!['username'];
    return userName;
    // print(userName);
  }

  Future<bool> _getMaskValue(String uid) async {
    var _userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    gloves_ok = _userData.data()!['gloves_ok'];
    // gloves_ok = _userData.data()!['gloves_ok'];
    return gloves_ok;
    // print(userName);
  }

  Future<bool> _getGlovesValue(String uid) async {
    var _userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    mask_ok = _userData.data()!['mask_ok'];
    // gloves_ok = _userData.data()!['gloves_ok'];
    return mask_ok;
    // print(userName);
  }

  Future<String> _getProfileImageUrl(String uid) async {
    var _userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    profileImageUrl = _userData.data()!['image_url'];
    // gloves_ok = _userData.data()!['gloves_ok'];
    return profileImageUrl;
    // print(userName);
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

    _getMaskValue(_uid).then((bool result) {
      setState(() {
        mask_ok = result;
      });
    });

    _getGlovesValue(_uid).then((bool result) {
      setState(() {
        gloves_ok = result;
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
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Instructions',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              //function here
              widget.selectedScreen('Instructions');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Collect',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              // function here
              setState(() {
                (mask_ok || gloves_ok)
                    ? widget.selectedScreen('Collect')
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please go through Health Check first!'),
                        ),
                      );
              });
            },
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Analyse',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              //function here
              print(mask_ok);
              print(gloves_ok);
              setState(() {
                (mask_ok || gloves_ok)
                    ? widget.selectedScreen('Analyse')
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please go through Health Check first!'),
                        ),
                      );
              });
            },
          ),
          ListTile(
            leading: Icon(
              Icons.location_city,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Locations',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              //function here

              widget.selectedScreen('Locations');
            },
          ),
        ],
      ),
    );
  }
}
