import 'package:flutter/material.dart';

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
  }

  var pred;
  void _analysis() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trash Categorization | Counting',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 8, 184, 99)),
        ),
      ),
    );
  }
}
