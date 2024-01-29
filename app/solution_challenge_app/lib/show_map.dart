import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class showMap extends StatefulWidget {
  showMap(this.fetchedRoute, {super.key});
  List<dynamic> fetchedRoute;

  @override
  State<showMap> createState() => _showMapState();
}

class _showMapState extends State<showMap> {
  // final userUid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    super.initState();
    curr = [];
    temp = [];
    markers = [];
    currentLocation = [];
    _loadItems();
  }

  List<LatLng> temp = [];

  List<double> curr = [];
  List<Marker> markers = [];
  List<double> currentLocation = [];

  void _loadItems() {
    List<LatLng> fetchedItem = [];
    List<Marker> locationMarker = [];
    var fetchedLocation = widget.fetchedRoute;
    int i = 0;
    int j = 1;
    int len = fetchedLocation.length;
    for (final data in fetchedLocation) {
      double lat = data[0];
      double lng = data[1];
      if (i == 0 || i == len - 1) {
        locationMarker.add(
          Marker(
            point: LatLng(lat, lng),
            child: Image.asset('assets/images/${0}.png'),
          ),
        );
      } else {
        locationMarker.add(
          Marker(
            point: LatLng(lat, lng),
            child: Image.asset('assets/images/${j}.png'),
          ),
        );
        j++;
      }
      i++;
    }

    currentLocation.add(fetchedLocation[0][0]);
    currentLocation.add(fetchedLocation[0][1]);
    for (final data in fetchedLocation) {
      double lat = data[0];
      double lng = data[1];
      fetchedItem.add(
        LatLng(lat, lng),
      );
    }

    // final url = Uri.https(
    //     'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
    //     'solution-challenge/${userUid}/chosen-locations.json');

    // final response = await http.get(url);
    // print(response.body);
    // final listData = json.decode(response.body);

    // for (final data in listData.entries) {
    //   double lat = data.value['latitude'];
    //   double lng = data.value['longitude'];

    //   try {
    //     currentLocation = data.value['current_location'];
    //   } catch (e) {
    //     print('Error retrieving current_location: $e');
    //     currentLocation = 'Default Location';
    //   }
    //   List<double> coordinates = [];
    //   coordinates.add(lat);
    //   coordinates.add(lng);
    //   fetchedItem.add(coordinates);
    //   locationMarker.add(
    //     Marker(point: LatLng(lat, lng), child: const FlutterLogo()),
    //   );
    //   // print(data.value['name']);
    // }
    // fetchedItem.add(currentLocation);
    // int i = 0;
    // for (final data in fetchedItem) {
    //   var matched = fetchedItem.where((element) => element == fetchedLocation);

    //   temp.add(
    //     LatLng(matched[0], matched[1]),
    //   );
    //   i++;
    // }
    print("The data now is ${widget.fetchedRoute}");
    print("The data is ${fetchedItem}");
    print("The data is ${locationMarker}");
    print("The Current is ${curr}");
    print("The length is ${len}");

    setState(() {
      temp = fetchedItem;
      markers = locationMarker;
      curr = currentLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        // 20.294918448642306, 85.7433748381501
        initialCenter: temp[0],
        // : LatLng(curr[0], curr[1]),
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/yuvrajsingh-mist/clrl9mbov003e01pe6460gqxq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieXV2cmFqc2luZ2gtbWlzdCIsImEiOiJjbHJoa2l6cG0wcTNlMnFwOWlrNDl5cDZ6In0.5mYZ0IGOQEub0fAOgML9qg',
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoieXV2cmFqc2luZ2gtbWlzdCIsImEiOiJjbHJoa2l6cG0wcTNlMnFwOWlrNDl5cDZ6In0.5mYZ0IGOQEub0fAOgML9qg',
            'id': 'mapbox.mapbox-streets-v8'
          },
        ),
        MarkerLayer(
          markers: markers,
          // [
          //   Marker(
          //     point: LatLng(20.294918448642306, 85.743374838150),
          //     child: const FlutterLogo(),
          //   ),
          // ],
        ),
        PolylineLayer(
          polylines: [
            Polyline(
                points: temp,
                color: Colors.green,
                borderStrokeWidth: BorderSide.strokeAlignCenter),
          ],
        ),
      ],
    );
  }
}
