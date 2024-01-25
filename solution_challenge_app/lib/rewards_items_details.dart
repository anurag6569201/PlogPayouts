import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:solution_challenge_app/data/coupons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uuid/uuid.dart';

class rewardsDetails extends StatefulWidget {
  rewardsDetails(this.cardData, {super.key});
  rewards_data cardData;

  @override
  State<rewardsDetails> createState() => _rewardsDetailsState();
}

class _rewardsDetailsState extends State<rewardsDetails> {
  void buyCardCheckout(BuildContext context) async {
    var collectedData = [];
    bool purchased = false;

    var snackbar = const SnackBar(content: Text('Not enough Points!'));
    final uuid = FirebaseAuth.instance.currentUser!.uid;
    print(uuid);
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection('redeemed_codes')
        .doc('List')
        .get();

    final codes =
        await FirebaseFirestore.instance.collection('users').doc(uuid).get();
    final fetechedData_points = codes.data();
    // final fetchedData_redeemed_codes = data.data();
    var points_available = fetechedData_points!['points'];
    // collectedData = fetchedData_redeemed_codes!['codes'];
    // for (final point in fetchedData!.entries) {
    //   // redeemed_card.add(point.value()['Code']);
    //   // points_available = point.value['points'];
    //   // print(point.value['points']);
    //   print(point);
    // }
    // print(widget.cardData.points_required);
    // print(dummyData[1].points_required);
    final uid = Uuid().v6();
    if (points_available >= widget.cardData.points_required) {
      // redeemed_card.add(widget.cardData.code);
      points_available -= widget.cardData.points_required;
      purchased = true;
      dummyData.remove(widget.cardData);
      collectedData.add([
        // redeemed_card.length,
        // redeemed_card,
        widget.cardData.name,
        widget.cardData.points_required,
        widget.cardData.money,
        // widget.cardData.money_icon,
        widget.cardData.url,
        widget.cardData.code,
        uid,
      ]);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uuid)
          .collection('redeemed_codes')
          .doc('List')
          .update({
        'codes_${uid}': collectedData[0],
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uuid)
          .update({'points': points_available});

      // FirebaseFirestore.instance.collection('users').doc(uuid).update(
      //     {'Redeemed_Cards': collectedData, 'points': points_available});
      // print(object)
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(uuid)
      //     .update({'points': points_available});
      snackbar = const SnackBar(content: Text('Success!'));
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void buyCardDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              scrollable: true,
              title: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 134, 10),
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                children: [
                  const Text(
                    'Are you sure you want to buy?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 134, 10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      buyCardCheckout(context);
                    },
                    icon: const Icon(Icons.sell),
                    label: const Text(
                      'Sure',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 134, 10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          buyCardDialogBox(context);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(widget.cardData.url),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
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
                      widget.cardData.name,
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
                        widget.cardData.money_icon,
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          '${widget.cardData.money}',
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
