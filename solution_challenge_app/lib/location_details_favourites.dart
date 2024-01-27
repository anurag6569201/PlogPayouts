import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/favourites_screen.dart';
import 'package:http/http.dart' as http;
import 'package:solution_challenge_app/show_map_favourites.dart';

// class localStoreLocations {
//   localStoreLocations(this.id, this.title, this.coordinates);

//   String id;
//   String title;
//   List<double> coordinates;
// }

class locationDetailsFavourite extends StatefulWidget {
  locationDetailsFavourite(this.category, {super.key});

  Category category;

  @override
  State<locationDetailsFavourite> createState() =>
      _locationDetailsFavouriteState();
}

class _locationDetailsFavouriteState extends State<locationDetailsFavourite> {
  // void _getLocationsData(String keyword) async {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
    // _loadItems();
    // fetchCurrentLocation();
  }

  // void fetchCurrentLocation() async {
  //   Location location = Location();

  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   locationData = await location.getLocation();
  // }

  // bool onPressed = false;
  void deleteILocation(Category category) {
    // if (onPressed) {
    final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
    print(userUid);
    final url = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/chosen-locations/${category.uuid}.json');
    http.delete(url);
    Navigator.of(context).pop();
    // setState(() {
    //   onPressed = !onPressed;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // bool onPressed = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        actions: [
          IconButton(
            onPressed: () {
              // (onPressed == false)
              //     ? _markFavourite(widget.category)
              //     : deleteILocation(widget.category);
              deleteILocation(widget.category);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _favourite(meal);
        //     },
        //     icon: const Icon(Icons.star),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // alignment: Alignment(0.5, 1),
          padding: EdgeInsets.all(40),
          margin: EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Id: ${widget.category.Id}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 134, 72)),
              ),
              // const Spacer(),

              const SizedBox(
                height: 16,
              ),

              Text(
                "Distance: ${double.parse(widget.category.distance.toStringAsFixed(2))} km",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 134, 72)),
              ),
              const SizedBox(
                height: 40,
              ),

              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => showMapFavourites(widget.category),
                    ));
                  },
                  icon: Icon(Icons.map),
                  label: const Text(
                    'Show on Map!',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 6, 134, 72)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
