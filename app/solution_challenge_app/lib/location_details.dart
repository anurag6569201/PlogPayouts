import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/favourites_screen.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
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
  var favourites = [];
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
              "Detecting your current location...Please Wait for 10 seconds"),
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
    favourites = [];
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

  Future<bool> checkIfExistsOrNot(Category category) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
    print(userUid);
    final url = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/chosen-locations.json');
    // final response = await http.get(url);

    // DatabaseReference ref = FirebaseDatabase.instance
    //     .ref("solution-challenge/${userUid}/chosen-locations");

    // final url = Uri.https(
    //     'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
    //     'solution-challenge/${userUid}/current-location.json');

    // final url_dist = 'http://34.170.198.187:8080/timeDistance?query=' + userUid;/
    // final url = Uri.https('127.0.0.1:5000', '/mask', {'query': _imageUrl});
    // print("url is: ${Uri.parse(url_dist)}");
    final response = await http.get(url);
    var body = response.body;
    var decoded = jsonDecode(body);
    var fetchedData = [];
    // print("body is ${body}");
    // print(response.body == null);
    // print(response.body);
    // print(body);
    // return true;
    print(decoded);
    if (decoded != null) {
      // var bodyMap = body as Map<String, dynamic>;
      for (final data in decoded.entries) {
        fetchedData.add(data.value['Id']);
        // // print(data.value['Id']);
        // // print(data.value);
        // print(body['Id']);
        // }
        // print(data);
        //     print(data);
      }
      // print(fetchedData.length);
      if (fetchedData.contains(category.Id) || fetchedData.length >= 3) {
        return true;
      } else {
        return false;
      }
    }
    // } else {
    //   return false;
    //   //   print(body);
    //   return false;
    //   for (final data in body) {
    //     fetchedData.add(body['Id']);
    //     // print(data.value['Id']);
    //     // print(data.value);
    //     print(body['Id']);
    //   }
    //   if (fetchedData.contains(category.Id)) {
    //     return true;
    //   } else {
    //     return false;
    // }
    else {
      return false;
    }
  }

  void _markFavourite(Category category) async {
    var _isExisting = false;

    _isExisting = await checkIfExistsOrNot(category);
    // print("Exusting value is ${_isExisting}");
    if (_isExisting == false) {
      final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
      // print(userUid);
      // final url = Uri.https(
      //     'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
      //     'solution-challenge/${userUid}/chosen-locations.json');

      DatabaseReference ref = FirebaseDatabase.instance
          .ref("solution-challenge/${userUid}/chosen-locations");
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
      await ref.push().set(
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
      );
      _alertFavouriteAdded();
    } else {
      _alertFavouriteAlreadyThere();
    }

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

  // bool onPressed = false;
  // void deleteILocation(Category category) {
  //   if (onPressed) {
  //     final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
  //     print(userUid);
  //     final url = Uri.https(
  //         'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
  //         'solution-challenge/${userUid}/chosen-locations/${category.uuid}.json');
  //     http.delete(url);
  //   }
  //   setState(() {
  //     onPressed = !onPressed;
  //   });
  // }

  void _alertFavouriteAdded() {
    final snackbar = SnackBar(
      content: Text('Success!'),
    );

    // ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    // });
  }

  void _alertFavouriteAlreadyThere() {
    final snackbar = SnackBar(
      content: Text(
          'Already marked as favourite! ||  Cannot favourite more than three places!'),
    );

    // ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
            splashColor: Colors.greenAccent,
            onPressed: () {
              // (onPressed == false)
              //     ? _markFavourite(widget.category)
              //     : deleteILocation(widget.category);
              _markFavourite(widget.category);
              // _alertFavouriteAdded();
            },
            icon: const Icon(Icons.star, color: Colors.green),
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
        // child: Container(
        // alignment: Alignment.center,
        // padding: EdgeInsets.all(40),
        // margin: EdgeInsets.all(40),
        child: Column(
          children: [
            //Add map here

            Card(
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 2,
              child: InkWell(
                onTap: () {
                  // buyCardDialogBox(context);
                },
                child: Stack(
                  children: [
                    FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(widget.category.imageUrl),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

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

            // Text(
            //   "Time: ",
            //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //         color: Theme.of(context).colorScheme.primary,
            //       ),
            // ),
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
          ],
        ),
      ),
    );
    // );
  }
}
