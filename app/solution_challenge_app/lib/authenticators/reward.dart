import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/authenticators/garbage_images.dart';

class reward extends StatefulWidget {
  const reward({super.key});

  @override
  State<reward> createState() => _rewardState();
}

void _showImagesGarbage(String uuid, BuildContext context) async {
  var images = [];
  final url_db = Uri.https(
      'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
      'solution-challenge/${uuid}/collected-garbage.json');

  final response = await http.get(url_db);
  // print(response.body);
  final listData = json.decode(response.body);

  for (final data in listData.entries) {
    images.add([
      data.value['count'],
      data.value['image_url'],
      data.value['name'],
    ]);
  }
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => garbageImages(images)),
  );
}

void _calculate(String uuid, BuildContext context) async {
  var data =
      await FirebaseFirestore.instance.collection('users').doc(uuid).get();
  var tempData = data.data();
  int accumulatedPoints = tempData!['points'];

  List<int> res = [];

  final url_db = Uri.https(
      'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
      'solution-challenge/${uuid}/collected-garbage.json');

  final response = await http.get(url_db);
  // print(response.body);
  final listData = json.decode(response.body);

  for (final data in listData.entries) {
    var category = data.value['name'];
    int count = data.value['count'];

    if (category == 'glass') {
      var price = 50 * count;
      res.add(price);
    } else if (category == 'plastic') {
      var price = 20 * count;
      res.add(price);
    } else if (category == 'metal') {
      var price = 30 * count;
      res.add(price);
    } else if (category == 'paper') {
      var price = 30 * count;
      res.add(price);
    } else if (category == 'glass') {
      var price = (Random().nextInt(30) + 20) * count;
      res.add(price);
    }
  }
  int reward_points = 0;
  for (final data in res) {
    reward_points += data;
  }
  reward_points += accumulatedPoints;
  FirebaseFirestore.instance
      .collection('users')
      .doc(uuid)
      .update({'points': reward_points, 'trash_deposited': true});

  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('user-images')
      .child('garbage-images-all')
      .child(uuid);

  ListResult result = await storageReference.listAll();

  for (Reference item in result.items) {
    await item.delete();
  }

  const snackbar = SnackBar(
    content: Text('Success'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
  // print(res);
  // print(listData);
}

class _rewardState extends State<reward> {
  var text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to the Rewards System!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 5, 134, 10),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the Candidate Code',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 134, 10),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 5, 134, 10)),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _calculate(text.text, context);
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text('All Good!'),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    _showImagesGarbage(text.text, context);
                  },
                  icon: const Icon(Icons.dirty_lens),
                  label: const Text('Show data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}