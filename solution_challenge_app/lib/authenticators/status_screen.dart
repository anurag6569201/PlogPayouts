import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Your Groceries"),
          // actions: [
          //   IconButton(
          //     onPressed: _addItem,
          //     icon: const Icon(Icons.add),
          //   ),
          // ],
          ),
      body: Dismissible(
        key: ValueKey(uuid),
        onDismissed: (direction) {},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: const NetworkImage(
                  'https://ci3.googleusercontent.com/meips/ADKq_NZwgOwFTkB0kNGuIYR60_wFbJmuBx43tdyr-MPFeBkeP4_TsyvBiBQVcTN6U0BJNkRSDLeI6RIRdbZx67CD_--8rVHKz5SKaOwaJJpp4UQ8s4huhHhb8Q8ibtkDf-UERm-fXRPdUOSssAJqYgRWkCpzVlj9-VwoyhMZ=s0-d-e1-ft#https://m.media-amazon.com/images/G/31/gc/designs/livepreview/a_generic_orange_in_noto_email_in-main'),
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
                    Text(
                      'SUCCESS!',
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
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.money,
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
