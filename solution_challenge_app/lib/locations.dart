import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/display_location_cards_data.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/location_grid_item.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

class displayLocations extends StatefulWidget {
  const displayLocations({super.key});

  @override
  State<displayLocations> createState() => _displayLocationsState();
}

class _displayLocationsState extends State<displayLocations> {
  late Category category;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // category.id = 'null';
  //   // category.color = Colors.black;
  //   // category.title = 'None';
  //   // category.coordinates = [];
  //   _chosenLocationAndFetchData();
  // }
  List<Category> _colectedData = [];
  void _chosenLocationAndFetchData() async {
    List<Category> _fetchedData = [];

    final _noOfItems =
        await FirebaseFirestore.instance.collection('locations').count().get();
    print(_noOfItems.count);

    if (_noOfItems.count != null) {
      for (int i = 0; i < _noOfItems.count!.toInt(); i++) {
        final _userData = await FirebaseFirestore.instance
            .collection('locations')
            .doc('L' + i.toString())
            .get();

        // Create a new instance of Category for each location data
        Category category = Category(
          id: _userData.data()!['id'],
          title: _userData.data()!['title'],
          color: Colors.orange, // You can set the desired color here
          coordinates: [20.289392134840174, 85.74188592015321],
        );
        print(category);
        _fetchedData.add(category);
      }
    }

    // setState(() {
    //   _fetchedData.isEmpty ? _fetchedData : [];
    // });

    setState(() {
      _colectedData = _fetchedData;
    });
    print(_fetchedData);
  }
  // void _chosenLocationAndFetchData() async {
  //   final _noOfItems =
  //       await FirebaseFirestore.instance.collection('locations').count().get();
  //   print(_noOfItems.count);
  //   // (_noOfItems.count == null) ? 0 : _noOfItems.count;
  //   if (_noOfItems.count != null) {
  //     for (int i = 0; i < _noOfItems.count!.toInt(); i++) {

  //       final _userData = await FirebaseFirestore.instance
  //           .collection('locations')
  //           .doc('L' + i.toString())
  //           .get();
  //       category.id = _userData.data()!['id'];
  //       category.title = _userData.data()!['title'];
  //       category.coordinates = _userData.data()!['coordinates'];
  //       _fetchedData.add(category);
  //       print(category);
  //     }
  //   }

  //   print(_fetchedData);

  //   // local.id = id;
  //   // print(userName);
  //   //    String? _currentAddress;
  //   // Position? _currentPosition;

  //   // Future<bool> _handleLocationPermission() async {
  //   //   bool serviceEnabled;
  //   //   LocationPermission permission;

  //   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   //   if (!serviceEnabled) {
  //   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //   //         content: Text(
  //   //             'Location services are disabled. Please enable the services')));
  //   //     return false;
  //   //   }
  //   //   permission = await Geolocator.checkPermission();
  //   //   if (permission == LocationPermission.denied) {
  //   //     permission = await Geolocator.requestPermission();
  //   //     if (permission == LocationPermission.denied) {
  //   //       ScaffoldMessenger.of(context).showSnackBar(
  //   //           const SnackBar(content: Text('Location permissions are denied')));
  //   //       return false;
  //   //     }
  //   //   }
  //   //   if (permission == LocationPermission.deniedForever) {
  //   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //   //         content: Text(
  //   //             'Location permissions are permanently denied, we cannot request permissions.')));
  //   //     return false;
  //   //   }
  //   //   return true;
  //   // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose a location!',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: _chosenLocationAndFetchData,
            icon: const Icon(Icons.location_city),
            label: const Text('Detect my location'),
          ),
          ElevatedButton.icon(
            onPressed: _chosenLocationAndFetchData,
            icon: const Icon(Icons.refresh),
            label: const Text('Refesh'),
          ),
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        padding: const EdgeInsets.all(10),
        children: [
          for (final item in _colectedData) locationGridItem(item),
        ],
      ),
    );
  }
}
