import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/contribute_locations.dart';
import 'package:solution_challenge_app/data/display_location_cards_data.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/location_grid_item.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:solution_challenge_app/location_grid_view.dart';

class displayLocations extends StatefulWidget {
  const displayLocations({super.key});

  @override
  State<displayLocations> createState() => _displayLocationsState();
}

class _displayLocationsState extends State<displayLocations> {
  // @override

  List<Category> _collectedData = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
    // _collectedData = [];
  }

  final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
  List<Category> fetchedItem = [];
  void _loadItems() async {
    final url = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}.json');

  final url_dist = 'http://10.0.2.2:5000/timeDistance?query=' + userUid;
    // final url = Uri.https('127.0.0.1:5000', '/mask', {'query': _imageUrl});
    // print("url is: ${Uri.parse(url_dist)}");
    final response_dist = await http.get(Uri.parse(url_dist));
    print(response_dist.body);
    // final response = await http.get(url);
    var fetchedDistance = jsonDecode(response_dist.body)['distance'];

    final response = await http.get(url);
    print(response.body);
    final listData = json.decode(response.body);

    for (final data in listData.entries) {
      double lat = data.value['latitude'];
      double lng = data.value['longitude'];
      List<double> coordinates = [];
      coordinates.add(lat);
      coordinates.add(lng);
      fetchedItem.add(
        Category(
            Id: data.value['Id'].toString(),
            title: data.value['name'].toString(),
            color: Color(data.value['color']),
            coordinates: coordinates,
            imageUrl: data.value['image_url'].toString(),
            uuid: data.key.toString(),
            distance: fetchedDistance),
      );
      print("The unique id is ${data.key.toString()}");
    }
    // setState(() {
    //   _collectedData = fetchedItem;
    // });
    print("The data is ${fetchedItem}");
  }

  void _addItems() async {
    final results = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => newItems(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TrashTracker',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(70),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _addItems,
              icon: const Icon(Icons.add_card),
              label: const Text('Contribute! (Add a location)'),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => locationGridView(fetchedItem),
                  ),
                );
              },
              icon: const Icon(Icons.view_agenda),
              label: const Text('View Stored Locations'),
            ),
          ],
        ),
      ),
    );
  }
}
