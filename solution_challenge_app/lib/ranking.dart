import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ranking extends StatefulWidget {
  const ranking({super.key});

  @override
  State<ranking> createState() => _rankingState();
}

void fetchData() async {
  final data  = await FirebaseFirestore.instance.collection('users').get();

  // final fetchedData = data.;

  // for(final data in data.)
  print(data);

}

class _rankingState extends State<ranking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    Widget content = 
    return content
  }
}