import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/location_grid_item.dart';
import 'package:http/http.dart' as http;
import 'package:solution_challenge_app/location_grid_item_favourite.dart';
import 'package:solution_challenge_app/routes.dart';

class favouritesScreen extends StatefulWidget {
  favouritesScreen({super.key});

  @override
  State<favouritesScreen> createState() => _favouritesScreenState();
}

class _favouritesScreenState extends State<favouritesScreen> {
  List<Category> _chosenLocations = [];

  final userUid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadItems();
  }

  void _loadItems() async {
    List<Category> fetchedItem = [];
    final url = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/chosen-locations.json');

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
        ),
      );
      // print(data.value['name']);
    }
    setState(() {
      _chosenLocations = fetchedItem;
    });

    // print("The data is ${_chosenLocations[0].uuid}");
  }

  // List<int> routes = [];
  // bool _isLoading = false;
  // void _routeOptimization() async {
  //   //here
  //   setState(() {
  //     // _isLoading = false;
  //     _isLoading = true;
  //   });
  //   final url = 'http://10.0.2.2:5000/locations?query=${userUid}';

  //   final response = await http.get(Uri.parse(url));
  //   print(response.body);
  //   final fetchedData = json.decode(response.body);

  //   setState(() {
  //     routes = fetchedData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Chosen Locations',
          style: TextStyle(fontSize: 16),
        ),
        // actions: [
        //   ElevatedButton.icon(
        //     onPressed: _Favourites,
        //     icon: const Icon(Icons.favorite_outline),
        //     label: const Text('Favourites'),
        //   ),
        // ElevatedButton.icon(
        //   onPressed: () {
        //     deleteCollection('locations');
        //   },
        //   icon: const Icon(Icons.refresh),
        //   label: const Text('Refesh'),
        // ),
        // ],
      ),
      body: Stack(
        children: [
          GridView(
            // shrinkWrap: true,
            // controller: _controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            padding: const EdgeInsets.all(10),
            children: [
              for (final item in _chosenLocations)
                locationGridItemFavourite(item),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 18,
            right: 18,
            child: ElevatedButton.icon(
                    onPressed: () {
                      // _routeOptimization();
                      // setState(() {
                      //   _isLoading = false;
                        //   // if (routes.isEmpty == false) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => routesScreen(),
                              ),
                            );
                        //   // }
                      // });
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Plan Your Route'),
                  ),
          )
        ],
      ),
    );
  }
}
