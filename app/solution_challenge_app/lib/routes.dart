import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:solution_challenge_app/show_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class routesScreen extends StatefulWidget {
  const routesScreen({super.key});

  @override
  State<routesScreen> createState() => _routesScreenState();
}

class _routesScreenState extends State<routesScreen> {
  final userUid = FirebaseAuth.instance.currentUser!.uid.toString();

  List<dynamic> routes = [];
  bool _isLoading = false;
  bool _openMaps = false;
  void _routeOptimization() async {
    //here
    setState(() {
      // _isLoading = false;
      _isLoading = true;
    });
    final url = 'http://10.0.2.2:8080/locations?query=${userUid}';

    final response = await http.get(Uri.parse(url));
    print(response.body);
    final fetchedData = json.decode(response.body);
    // routes = json.decode(response.body);

    setState(
      () {
        _isLoading = false;
        routes = fetchedData;
        _openMaps = true;
      },
    );
    // setState(
    //   () {
    //     // _isLoading = false;
    //     routes = fetchedData;
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recommended Route',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body:
          // alignment: Alignment.center,
          Column(
        // mainAxisAlignment: MainAxisAlignment.,
        // crossAxisAlignment: CrossAxisAlignment.center,d
        children: [
          Container(
              // backgroundColor: Theme.of(context).colorScheme.background,
              // padding: EdgeInsets.all(20),
              // margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 400,
              // foregroundDecoration: BoxDecoration(
              //     border: Border.all(color: Colors.greenAccent)),
              child: Image.asset('assets/images/map.jpg')),

          const SizedBox(
            height: 20,
          ),

          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,

          // const SizedBox(
          //   width: 20,
          // ),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _routeOptimization,
            style:
                ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
            icon: _isLoading
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(),
                  )
                : const Icon(Icons.feedback),
            label: const Text('Start Optimizing!'),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  icon: const Icon(Icons.map),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    !_openMaps
                        ? null
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => showMap(routes),
                            ),
                          );
                  },
                  label: const Text('Show Map')),
              const SizedBox(
                height: 30,
              ),
              // ElevatedButton.icon(
              //   icon: const Icon(Icons.route),
              //   onPressed: () {
              //     // Navigator.of(context).pop();
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (ctx) => SampleNavigationApp(routes),
              //       ),
              //     );
              //   },
              //   label: const Text('Nvaigate'),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
