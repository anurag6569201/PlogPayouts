import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class reward extends StatefulWidget {
  const reward({super.key});

  @override
  State<reward> createState() => _rewardState();
}

void _calculate(String uuid) {
  final res = [];
  final data = Uri.https(
      'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
      'solution-challenge/${uuid}/collected-garbage.json');
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
            ElevatedButton.icon(
              onPressed: () {
                _calculate(text.text.toString());
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
