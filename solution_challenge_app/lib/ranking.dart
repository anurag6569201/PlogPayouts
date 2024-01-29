import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/ranking_details.dart';
import 'package:transparent_image/transparent_image.dart';

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
    _startTimer();
    fetchData();
  }

  late Timer _timer;
  int _seconds = 0;

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
        element.id
        // 'https://cdn.stockmediaserver.com/smsimg31/pv/IsignstockContributors/IST_18013_01975.jpg?token=OMclyPtGYLDU1HV00qjWfr3n7XlhYcYgejSrwNfugcs&class=pv&smss=52&expires=4102358400'
      ]);
    }
    ;

    tempData.sort((a, b) => b[2].compareTo(a[2]));

    for (final element in tempData) {
      if (i == 1) {
        element.add(
          'https://cdn.stockmediaserver.com/smsimg31/pv/IsignstockContributors/IST_18013_01975.jpg?token=OMclyPtGYLDU1HV00qjWfr3n7XlhYcYgejSrwNfugcs&class=pv&smss=52&expires=4102358400',
        );
        element.add(3);
      } else if (i == 2) {
        element.add(
          'https://st5.depositphotos.com/8535708/67121/v/450/depositphotos_671210544-stock-illustration-award-champion-trophy-silver-medal.jpg',
        );
        element.add(2);
      } else if (i == 3) {
        element.add(
          'https://vectorstate.com/stock-photo-preview/140399635/ist_18013_01978.jpg',
        );
        element.add(1);
      } else {
        element.add(
          'https://firebasestorage.googleapis.com/v0/b/solution-challenge-app-409f6.appspot.com/o/user-images%2Fothers.jpg?alt=media&token=e8cf357a-187b-4344-a4f8-cdafe9e4384c',
        );
        element.add(0);
      }
      i += 1;
    }
    ;
    print(tempData);
    setState(() {
      fetchedData = tempData;
    });
  }

  void randomRewards(BuildContext context, int index) async {
    if (index == 0) {
      var uuid = fetchedData[index][3];

      final data =
          await FirebaseFirestore.instance.collection('users').doc(uuid).get();

      final decoded = data.data();
      var current_taps = fetchedData[index][5];
      print(current_taps);
      if (current_taps > 0) {
        FirebaseFirestore.instance.collection('users').doc(uuid).update({
          'taps_remaining': current_taps - 1,
        });

        fetchedData[index][5] = current_taps - 1;
        var random_points = Random().nextInt(decoded!['points']);
        var random_reward =
            ((2.72) * (-1) * (_seconds / (3600)) * random_points).toInt();
        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              scrollable: true,
              title: const Text(
                'Congratulations! You received:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 134, 10),
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                children: [
                  Text(
                    random_reward.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 134, 10),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    } else if (index == 1) {
      var uuid = fetchedData[index][3];

      final data =
          await FirebaseFirestore.instance.collection('users').doc(uuid).get();

      final decoded = data.data();
      var current_taps = fetchedData[index][5];
      print(current_taps);
      if (current_taps > 0) {
        FirebaseFirestore.instance.collection('users').doc(uuid).update({
          'taps_remaining': current_taps - 1,
        });

        fetchedData[index][5] = current_taps - 1;
        var random_points = Random().nextInt(decoded!['points']);
        var random_reward =
            ((2.72) * (-1) * (_seconds / (3600)) * random_points).toInt();

        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              scrollable: true,
              title: const Text(
                'Congratulations! You received:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 134, 10),
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                children: [
                  Text(
                    random_reward.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 134, 10),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    } else if (index == 2) {
      var uuid = fetchedData[index][3];

      final data =
          await FirebaseFirestore.instance.collection('users').doc(uuid).get();

      final decoded = data.data();
      var current_taps = fetchedData[index][5];
      print(current_taps);
      if (current_taps > 0) {
        FirebaseFirestore.instance.collection('users').doc(uuid).update({
          'taps_remaining': current_taps - 1,
        });

        fetchedData[index][5] = current_taps - 1;
        var random_points = Random().nextInt(decoded!['points']);
        var random_reward =
            ((2.72) * (-1) * (_seconds / (3600)) * random_points).toInt();
        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              scrollable: true,
              title: const Text(
                'Congratulations! You received:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 134, 10),
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                children: [
                  Text(
                    random_reward.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 134, 10),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            scrollable: true,
            title: const Text(
              'Better Luck Next Time!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 134, 10),
              ),
              textAlign: TextAlign.center,
            ),
            contentPadding: EdgeInsets.all(20),
            content: Column(
                // children: [
                //   Text(
                //     '',
                //     style: const TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.bold,
                //       color: Color.fromARGB(255, 5, 134, 10),
                //     ),
                //   )
                // ],
                ),
          ),
        ),
      );
    }
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);

    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        _seconds++;
      });
    });

    @override
    void dispose() {
      _timer.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = (fetchedData.isEmpty)
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
            itemBuilder: (ctx, index) =>
                // rankingDetails(
                //   fetchedData[index],
                // ),
                InkWell(
                  onTap: () => randomRewards(ctx, index),
                  child: Column(
                    children: [
                      // Image.asset('assets/images/trophies.jpg', scale: 2),
                      Card(
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.hardEdge,
                        elevation: 2,
                        child: Stack(
                          children: [
                            FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(fetchedData[index][4]),
                              fit: BoxFit.cover,
                              height: 210,
                              width: double.infinity,
                            ),
                            Positioned(
                              bottom: 0,
                              top: 130,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black54,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 44),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      fetchedData[index][1],
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 12,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.money,
                                          color: Colors.white,
                                        ),
                                        // const SizedBox(
                                        //   height: 25,
                                        // ),
                                        Text(
                                          '${fetchedData[index][2]}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        CircleAvatar(
                                          radius: 15.0,
                                          backgroundImage: NetworkImage(
                                              fetchedData[index][0]),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ],
                                    ),
                                    // const Spacer(),
                                    // const Icon(
                                    //   Icons.point_of_sale,
                                    //   color: Colors.white,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
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
