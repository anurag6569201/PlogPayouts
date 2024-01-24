import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

void checkStatus(){
  
}
class _StatusState extends State<Status> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Reward Status',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 5, 134, 10),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // backgroundColor: Theme.of(context).colorScheme.background,
              // padding: EdgeInsets.all(20),
              // margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 400,
              // foregroundDecoration: BoxDecoration(
              //     border: Border.all(color: Colors.greenAccent)),
              child:
                  Image.asset('assets/images/rewards-0-removebg-preview.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: checkStatus,
                icon: Icon(Icons.check),
                label: Text('Check your reward Status'))
          ],
        ),
      ),
    );
  }
}
