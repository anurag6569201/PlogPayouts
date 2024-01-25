import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/Store.dart';
import 'package:solution_challenge_app/authenticators/reward.dart';
import 'package:transparent_image/transparent_image.dart';

class statusScreen extends StatefulWidget {
  statusScreen(this.points, {super.key});

  int points;
  // String time;

  @override
  State<statusScreen> createState() => statusScreenState();
}

class statusScreenState extends State<statusScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    reward_points = widget.points.toString();
  }

  var reward_points;
  final uuid = FirebaseAuth.instance.currentUser!.uid;

  void receivedPoints() async {
    var data =
        await FirebaseFirestore.instance.collection('users').doc(uuid).get();
    var tempData = data.data();
    reward_points = tempData!['points'];

    FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .update({'points': reward_points, 'trash_deposited': false});

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Store(reward_points),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Reward Points",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 5, 134, 10),
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: _addItem,
        //     icon: const Icon(Icons.add),
        //   ),
        // ],
      ),
      body: Dismissible(
        key: ValueKey(uuid),
        onDismissed: (direction) {
          receivedPoints();
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: const NetworkImage(
                  'https://ci3.googleusercontent.com/meips/ADKq_Nb38T5FVwp-gYi01dP2miqart7TVQfL7KkfwFZHrzbzc37-w8BKAeXW8VfdCJLF9KFUjRcMWyWobNfj8_8mpqGoQUk6McApSA6wWjL1xSXDZ3lWel-xJOnXl22tx7p1QzdiFitgIGJkXnSC9ydd23hzM3L6Q1iNJjF9MPoLr8w=s0-d-e1-ft#https://m.media-amazon.com/images/G/31/gc/designs/livepreview/congratulations_greatwin_noto_email_in-main'),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              // alignment: Alignment(0, 0),
            ),
            Positioned(
              bottom: 0,
              top: 115,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    const Text(
                      'SUCCESS!',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 17,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'PlogPoints- ${reward_points}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
