import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class reward extends StatefulWidget {
  const reward({super.key});

  @override
  State<reward> createState() => _rewardState();
}

void _calculate(String uuid, BuildContext context) async {
  List<int> res = [];
  final url_db = Uri.https(
      'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
      'solution-challenge/${uuid}/collected-garbage.json');

  final response = await http.get(url_db);
  // print(response.body);
  final listData = json.decode(response.body);

  for (final data in listData.entries) {
    var category = data.value['name'];
    var count = data.value['count'];

    if (category == 'glass') {
      var price = 50;
      res.add(price);
    } else if (category == 'plastic') {
      var price = 20;
      res.add(price);
    } else if (category == 'metal') {
      var price = 30;
      res.add(price);
    } else if (category == 'paper') {
      var price = 30;
      res.add(price);
    } else if (category == 'glass') {
      var price = Random().nextInt(30) + 20;
      res.add(price);
    }
  }
  int reward_points = 0;
  for (final data in res) {
    reward_points += data;
  }
  FirebaseFirestore.instance
      .collection('users')
      .doc(uuid)
      .update({'points': reward_points, 'trash_deposited': true});

  const snackbar = SnackBar(
    content: Text('Success'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
  print(res);
  print(listData);
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
            ElevatedButton.icon(
              onPressed: () {
                _calculate(text.text, context);
              },
              icon: const Icon(Icons.calculate),
              label: const Text('Fetch data'),
            ),
          ],
        ),
      ),
    );
  }
}
