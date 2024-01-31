import 'dart:convert';
import 'dart:io';
// import 'dart:js_interop';
// import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:solution_challenge_app/Analyse.dart';
import 'package:uuid/uuid.dart';

class Collect extends StatefulWidget {
  const Collect({super.key});

  @override
  State<Collect> createState() => _CollectState();
}

class _CollectState extends State<Collect> {
  var saved;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    saved = false;
  }

  // bool _loading = true;
  File? _pickedImageFile = null;
  final userUid = FirebaseAuth.instance.currentUser!.uid.toString();

  void _pickImageCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

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

  bool ok = true;
  void _saveGarbageImage() async {
    // print(fetchedUid);
    setState(() {
      ok = false;
    });
    final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
    var uuid = Uuid().v6();
    final _storeImage = FirebaseStorage.instance
        .ref()
        .child('user-images')
        .child('garbage-images-all')
        .child('${userUid}')
        .child('garbage_${uuid}.jpg');

    await _storeImage.putFile(_pickedImageFile!);
    final _imageUrl = await _storeImage.getDownloadURL();

    final url =
        'http://34.171.172.163:8080/garbage?query=' + _imageUrl.toString();

    print("url is: ${Uri.parse(url)}");
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    var pred = jsonDecode(response.body)['prediction'];
    var counting = jsonDecode(response.body)['count'];

    // print(userUid);
    final url_db = Uri.https(
        'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
        'solution-challenge/${userUid}/collected-garbage.json');

    final response_db = await http.post(
      url_db,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': pred,
          'count': counting,
          'image_url': _imageUrl,
        },
      ),
    );

    if (_imageUrl.isNotEmpty) saved = true;

    ScaffoldMessenger.of(context).clearSnackBars();
    saved == true
        ? ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Captured'),
            ),
          )
        : ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Try again'),
            ),
          );
    setState(() {
      ok = true;
    });
    // FirebaseFirestore.instance.collection('users').doc(userUid).update({
    //   // 'username': _enteredUserName,
    //   // 'email': _enteredEmail,
    //   'image_url_garbage_${uuid}': _imageUrl
    // });
    // final url = 'http://10.0.2.2:5000/garbage?query=' + _imageUrl.toString();
    // // final url = Uri.https('127.0.0.1:5000', '/mask', {'query': _imageUrl});
    // print("url is: ${Uri.parse(url)}");
    // http.Response response = await http.get(Uri.parse(url));
    // print(response.body);
    // // final response = await http.get(url);
    // var temp = jsonDecode(response.body)['prediction'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garbage Collection Page',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 6, 134, 72))),
        backgroundColor: Color.fromARGB(255, 127, 242, 186),
      ),
      body:
          // padding: const EdgeInsets.fromLTRB(20, 30, 20, 60),
          // margin: const EdgeInsets.fromLTRB(20, 60, 20, 60),
          // alignment: Alignment.center,
          Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Colors.orangeAccent, Colors.greenAccent],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight),
        // ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              // backgroundColor: Theme.of(context).colorScheme.background,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 400,
              foregroundDecoration:
                  BoxDecoration(border: Border.all(color: Colors.greenAccent)),
              child: _pickedImageFile != null
                  ? Image(
                      image: FileImage(_pickedImageFile!),
                    )
                  : null,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageGallery,
                  icon: const Icon(Icons.add_to_photos),
                  label: const Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer),
                ),
                (ok == true)
                    ? ElevatedButton.icon(
                        onPressed: _saveGarbageImage,
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer),
                      )
                    : CircularProgressIndicator(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Analyse(),
                ));
              },
              icon: const Icon(Icons.analytics),
              label: const Text('Analyse'),
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer),
            ),
            // SnackBar(content: )
          ],
        ),
      ),
    );
  }
}
