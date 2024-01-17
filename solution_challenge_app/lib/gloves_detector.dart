import 'dart:convert';
import 'dart:io';
// import 'dart:js_interop';
// import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class glovesDetector extends StatefulWidget {
  glovesDetector(this._uid, {super.key});
  String _uid;
  @override
  State<glovesDetector> createState() => glovesDetectorState();
}

class glovesDetectorState extends State<glovesDetector> {
  var fetchedUid;
  var prediciton_gloves;
  var finalPredMask;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedUid = widget._uid;
    // prediciton_mask = false;
  }

  // bool _loading = true;
  File? _pickedImageFile = null;

  void _pickImageGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    // final url = Uri.https(
    //     '127.0.0.1:5000', '/mask', {'query': pickedImage.path.toString()});
    // final response = await http.get(url);
    // // print(response.body);
    // // print(url);
    // print(pickedImage.path.toString());

    setState(() {
      _pickedImageFile = File(pickedImage.path);
      // _loading = false;

      // print(_pickedImageFile);
    });
  }

  void _pickImageCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage == null) {
      return;
    }
    // final url =
    //     Uri.https('127.0.0.1:5000', '/mask', {'query': pickedImage.path});
    // final response = await http.get(url);
    // print(response.body);
    // print(url);
    setState(() {
      _pickedImageFile = File(pickedImage.path);
      // _loading = false;
      // print(_pickedImageFile);
    });
  }

  void _detectGloves() async {
    // print(fetchedUid);

    final _storeImage = FirebaseStorage.instance
        .ref()
        .child('user-images')
        .child('gloves')
        .child('${fetchedUid}.jpg');

    await _storeImage.putFile(_pickedImageFile!);
    final _imageUrl = await _storeImage.getDownloadURL();

    FirebaseFirestore.instance.collection('users').doc(fetchedUid).update({
      // 'username': _enteredUserName,
      // 'email': _enteredEmail,
      'image_url_gloves': _imageUrl
    });
    final url = 'http://10.0.2.2:5000/gloves?query=' + _imageUrl.toString();
    // final url = Uri.https('127.0.0.1:5000', '/mask', {'query': _imageUrl});
    print("url is: ${Uri.parse(url)}");
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    // final response = await http.get(url);
    var temp = jsonDecode(response.body)['prediction'];
    print(temp);
    if (temp == 1) prediciton_gloves = true;
    FirebaseFirestore.instance.collection('users').doc(fetchedUid).update({
      // 'username': _enteredUserName,
      // 'email': _enteredEmail,
      'gloves_ok': prediciton_gloves
    });
    // setState(() {
    //   prediciton_mask = true;
    // });

    ScaffoldMessenger.of(context).clearSnackBars();
    prediciton_gloves == true
        ? ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gloves Detected!'),
            ),
          )
        : ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No gloves Detected'),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to Safety Check Portal!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(
            {"Gloves": prediciton_gloves},
          );
          return false;
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 60),
          margin: const EdgeInsets.fromLTRB(20, 60, 20, 60),
          // alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  'Click a pick of you wearing a pair of gloves.',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 50),
                CircleAvatar(
                  // backgroundColor: Theme.of(context).colorScheme.background,
                  foregroundImage: _pickedImageFile != null
                      ? FileImage(_pickedImageFile!)
                      : null,
                  radius: 69,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickImageGallery,
                      icon: const Icon(Icons.add_to_photos),
                      label: const Text('Gallery'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    // const Spacer(),
                    ElevatedButton.icon(
                      onPressed: _pickImageCamera,
                      icon: const Icon(Icons.add_to_photos),
                      label: const Text('Open Camera'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _detectGloves();
                  },
                  icon: const Icon(Icons.done),
                  label: const Text('Check'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer),
                ),
                // SnackBar(content: )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
