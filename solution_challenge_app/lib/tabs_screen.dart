import 'package:flutter/material.dart';
import 'package:solution_challenge_app/Analyse.dart';
import 'package:solution_challenge_app/Collect.dart';
import 'package:solution_challenge_app/Home.dart';
import 'package:solution_challenge_app/Instructions.dart';
import 'package:solution_challenge_app/Status.dart';
import 'package:solution_challenge_app/Store.dart';
import 'package:solution_challenge_app/locations.dart';

import 'package:solution_challenge_app/main_drawer.dart';
import 'package:solution_challenge_app/qr_code.dart';

class TabsScreen extends StatefulWidget {
  final String uid;
  const TabsScreen(this.uid, {super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int indexPage = 0;
  void _selectPage(int index) {
    setState(() {
      indexPage = index;
    });
  }

  void _setScreen(String identifier) async {
    if (identifier == 'Instructions') {
      Navigator.of(context).pop();
      final results = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Instructions(),
        ),
      );
    }
    //else {
    //   Navigator.of(context).pop();
    // }
    if (identifier == 'Collect') {
      Navigator.of(context).pop();
      final results = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Collect(),
        ),
      );
    }
    //else {
    //   Navigator.of(context).pop();
    // }
    if (identifier == 'Analyse') {
      Navigator.of(context).pop();
      final results = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Analyse(),
        ),
      );
    }

    if (identifier == 'Locations') {
      Navigator.of(context).pop();
      final results = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => displayLocations(),
        ),
      );
    }

    if (identifier == 'QR Code') {
      Navigator.of(context).pop();
      final results = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => QRCodeGeneratorScreen(),
        ),
      );
    }
    // else {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    var _uid = widget.uid;

    Widget activeScreen = Home(_uid);
    // var activePageTitle = 'About';
    if (indexPage == 1) {
      activeScreen = Store();
      // activePageTitle = 'Your Favourites';
    }
    if (indexPage == 2) {
      activeScreen = Status();
    }

    return Scaffold(
      appBar: AppBar(
          // title: Text(activePageTitle),
          ),
      drawer: MainDrawer(_setScreen, _uid),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: indexPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.start), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.start), label: 'Status')
        ],
      ),
    );
  }
}
