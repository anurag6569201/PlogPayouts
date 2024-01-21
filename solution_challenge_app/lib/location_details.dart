import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/favourites_screen.dart';
import 'package:http/http.dart' as http;

// class localStoreLocations {
//   localStoreLocations(this.id, this.title, this.coordinates);

//   String id;
//   String title;
//   List<double> coordinates;
// }

class locationDetails extends StatefulWidget {
  locationDetails(this.category, {super.key});

  Category category;

  @override
  State<locationDetails> createState() => _locationDetailsState();
}

class _locationDetailsState extends State<locationDetails> {
  // void _getLocationsData(String keyword) async {
  List<double> currentLatLng = [];
  var lat;
  var lng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLatLng = [];
    fetchCurrentLocation();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        
        context: context,
        builder: (BuildContext context) => AlertDialog(
          
          // backgroundColor: Theme.of(context).colorScheme.onBackground,
          title: const Text("IMPORTANT!"),
          content: const Text(
              "Detecting your current location...Please Wait for a few seconds"),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          
        ),
      );
    });
  }

  void fetchCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    lat = locationData.latitude;
    lng = locationData.longitude;
    currentLatLng.add(lat);
    currentLatLng.add(lng);
  }

  void _markFavourite(Category category) async {
    // if (_isExisting) {
    final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
    print(userUid);
    final url = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/chosen-locations.json');
    // var v6 = uuid.v6();

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(_userCredentials.user!.uid)
    //     .set({
    //   'username': _enteredUserName,
    //   'email': _enteredEmail,
    //   'image_url': _imageUrl
    // });
    print("Curent location is: ${currentLatLng}");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': category.title,
          'latitude': category.coordinates[0],
          'longitude': category.coordinates[1],
          'image_url': category.imageUrl,
          'color': category.color.value,
          'Id': category.Id,
          'uuid': category.uuid,
          'current_location': currentLatLng,
        },
      ),
    );
    // setState(() {
    //   _isExisting = !_isExisting;
    // });
    // } else {
    //   final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
    //   print(userUid);
    //   final url = Uri.https(
    //       'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
    //       'solution-challenge/${userUid}/chosen-locations/${category.uuid}.json');
    //   http.delete(url);
    // }
    // setState(() {
    //   _isExisting = !_isExisting;
    // });
  }

  bool onPressed = false;
  void deleteILocation(Category category) {
    if (onPressed) {
      final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
      print(userUid);
      final url = Uri.https(
          'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
          'solution-challenge/${userUid}/chosen-locations/${category.uuid}.json');
      http.delete(url);
    }
    setState(() {
      onPressed = !onPressed;
    });
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
              _markFavourite(widget.category);
            },
            icon: const Icon(Icons.star),
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
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              //Add map here

              // Image.network(
              //   meal.imageUrl,
              //   height: 300,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              const SizedBox(
                height: 16,
              ),

              Text(
                "Id: ${widget.category.Id}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 16,
              ),

              Text(
                "Time: ",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 16,
              ),

              Text(
                "Distance: ",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
