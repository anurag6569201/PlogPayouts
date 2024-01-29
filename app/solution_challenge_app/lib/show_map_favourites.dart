import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:http/http.dart' as http;

class showMapFavourites extends StatefulWidget {
  showMapFavourites(this.category, {super.key});
  Category category;

  @override
  State<showMapFavourites> createState() => _showMapFavouritesState();
}

class _showMapFavouritesState extends State<showMapFavourites> {
  @override
  void initState() {
    // TODO: implement initState
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

  void _loadItems() async {
    List<LatLng> fetchedItem = [];
    List<Marker> locationMarker = [];
    var fetchedLocation = widget.category.coordinates;

    double lat = fetchedLocation[0];
    double lng = fetchedLocation[1];

    final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
    final url = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/chosen-locations.json');

    final response = await http.get(url);
    // print(response.body);
    final listData = json.decode(response.body);
    var tempCurrentLocation;
    // print(listData);
    for (final data in listData.entries) {
      tempCurrentLocation = data.value['current_location'];
      // print(data.value);
    }
    double lat_curr = tempCurrentLocation[0];
    double lng_curr = tempCurrentLocation[1];

    locationMarker.add(
      Marker(
        point: LatLng(lat, lng),
        child: Image.asset('assets/images/pinpoint.png'),
      ),
    );

    locationMarker.add(
      Marker(
        point: LatLng(lat_curr, lng_curr),
        child: Image.asset('assets/images/pinpoint.png'),
      ),
    );
    print(locationMarker);
    currentLocation.add(tempCurrentLocation[0]);
    currentLocation.add(tempCurrentLocation[1]);

    fetchedItem.add(
      LatLng(lat_curr, lng_curr),
    );

    fetchedItem.add(
      LatLng(lat, lng),
    );

    setState(() {
      temp = fetchedItem;
      markers = locationMarker;
      curr = currentLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = (temp.isNotEmpty && markers.isNotEmpty && curr.isNotEmpty)
        ? FlutterMap(
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
          )
        : Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(25),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Wait for a moment...",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 6, 134, 72)),
                  ),
                ],
              ),
            ),
          );
    return Scaffold(
      body: content,
    );
  }
}
