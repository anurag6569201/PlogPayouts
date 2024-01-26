import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/ranking_details.dart';

class ranking extends StatefulWidget {
  const ranking({super.key});

  @override
  State<ranking> createState() => _rankingState();
}

class _rankingState extends State<ranking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  var fetchedData = [];
  void fetchData() async {
    var tempData = [];
    final data = await FirebaseFirestore.instance.collection('users').get();
    int i = 1;
    for (final element in data.docs) {
      tempData.add([
        element.data()['image_url'],
        element.data()['username'],
        element.data()['points'],
        // 'https://cdn.stockmediaserver.com/smsimg31/pv/IsignstockContributors/IST_18013_01975.jpg?token=OMclyPtGYLDU1HV00qjWfr3n7XlhYcYgejSrwNfugcs&class=pv&smss=52&expires=4102358400'
      ]);
    }
    ;

    tempData.sort((a, b) => b[2].compareTo(a[2]));

    for (final element in tempData) {
      if (i == 1) {
        element.add(
            'https://cdn.stockmediaserver.com/smsimg31/pv/IsignstockContributors/IST_18013_01975.jpg?token=OMclyPtGYLDU1HV00qjWfr3n7XlhYcYgejSrwNfugcs&class=pv&smss=52&expires=4102358400');
      } else if (i == 2) {
        element.add(
            'https://st5.depositphotos.com/8535708/67121/v/450/depositphotos_671210544-stock-illustration-award-champion-trophy-silver-medal.jpg');
      } else if (i == 3) {
        element.add(
            'https://vectorstate.com/stock-photo-preview/140399635/ist_18013_01978.jpg');
      } else {
        element.add(
            'https://firebasestorage.googleapis.com/v0/b/solution-challenge-app-409f6.appspot.com/o/user-images%2Fothers.jpg?alt=media&token=e8cf357a-187b-4344-a4f8-cdafe9e4384c');
      }
      i += 1;
    }
    ;
    print(tempData);
    setState(() {
      fetchedData = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = (fetchedData.length == 0)
        ? Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(25),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Wait...",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 6, 134, 72)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: fetchedData.length,
            itemBuilder: (ctx, index) => rankingDetails(
              fetchedData[index],
            ),
          );
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rankings!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 134, 10),
            ),
          ),
        ),
        body: content);
  }
}
