import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/display_fetched_garbage_items.dart';
import 'package:solution_challenge_app/garbage_class.dart';

class Analyse extends StatefulWidget {
  const Analyse({super.key});

  @override
  State<Analyse> createState() => _AnalyseState();
}

class _AnalyseState extends State<Analyse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _analysis();
    pred = [];
    fetchedData = [];

    // data = garbageData(name: '', count: 0, image_url: '');
  }

  var data;
  var fetchedData;
  var pred;

  void _analysis() async {
    var collectedData = [];

    final userUid = FirebaseAuth.instance.currentUser!.uid.toString();

    final url_db = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/collected-garbage.json');

    final response = await http.get(url_db);
    // print(response.body);
    final listData = json.decode(response.body);
    print(listData);
    for (final data in listData.entries) {
      var cnt = data.value['count'];
      var category = data.value['name'];
      var imgUrl = data.value['image_url'];
      collectedData.add(
        garbageData(name: category, count: cnt, image_url: imgUrl),
      );
      // print(data.value);
    }
    setState(() {
      fetchedData = collectedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: fetchedData.length,
      itemBuilder: (ctx, index) => garbageItems(
        fetchedData[index],
      ),
    );

    if (fetchedData.isEmpty) {
      content = Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(25),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Uh oh...Nothing here :(",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 134, 72)),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Try going through Analysis and Collection Screen first!",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 134, 72)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Trash Categorization | Counting',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 6, 134, 72)),
          ),
        ),
        body: content
        // Column(
        //   mainAxisSize: MainAxisSize.max,
        //   children: [
        //     Container(
        //       // alignment: Alignment.center,
        //       height: 180,
        //       width: 500,
        //       margin: EdgeInsets.all(15),
        //       decoration: BoxDecoration(
        //         color: Color.fromARGB(255, 243, 170, 76),
        //         borderRadius: BorderRadius.circular(20),
        //         boxShadow: [
        //           BoxShadow(
        //               color: Colors.grey.withOpacity(0.3),
        //               offset: Offset(-10.0, 10.0),
        //               blurRadius: 20.0,
        //               spreadRadius: 4.0),
        //         ],
        //       ),
        //     ),
        //   ],
        // )
        );
  }
}
