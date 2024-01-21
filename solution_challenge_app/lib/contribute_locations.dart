import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solution_challenge_app/location_image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class newItems extends StatefulWidget {
  const newItems({super.key});

  @override
  State<StatefulWidget> createState() {
    return _newItemsState();
  }
}

class _newItemsState extends State<newItems> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          // backgroundColor: Theme.of(context).colorScheme.onBackground,
          title: const Text("IMPORTANT!"),
          content: const Text(
              "Please use the Google Maps to get the exact details to fill."),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }

  var uuid = Uuid();

  var _enteredName = 'Name';
  double _enteredLongitude = 1;
  double _enteredLatitude = 1;
  int Id = 0;
  // var _selectedCategory = categories[Categories.other]!;
  var _isSending = false;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  void _saveItem() async {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      _formKey.currentState!.save();

      setState(() {
        _isSending = true;
      });
      final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
      print(userUid);
      final url = Uri.https(
          'solution-challenge-app-409f6-default-rtdb.firebaseio.com',
          'solution-challenge/${userUid}.json');
      var v6 = uuid.v6();

      final _storeImage = FirebaseStorage.instance
          .ref()
          .child('location-images')
          .child(userUid)
          .child('${_enteredName + v6}.jpg');

      await _storeImage.putFile(_selectedImage!);

      final _imageUrl = await _storeImage.getDownloadURL();

      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(_userCredentials.user!.uid)
      //     .set({
      //   'username': _enteredUserName,
      //   'email': _enteredEmail,
      //   'image_url': _imageUrl
      // });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': _enteredName,
            'latitude': _enteredLatitude,
            'longitude': _enteredLongitude,
            'image_url': _imageUrl,
            'color': Colors.orange.value,
            'Id': Id,
          },
        ),
      );

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
      // Navigator.of(context).pop(
      //   GroceryItem(
      //       id: DateTime.now().toString(),
      //       name: _enteredName,
      //       quantity: _enteredQuantity,
      //       category: _selectedCategory),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contributor's Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LocationImage((pickedImage) {
                _selectedImage = pickedImage;
              }),
              TextFormField(
                // initialValue: _enteredName,
                maxLength: 50,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  label: Text('Name of the place'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Name must be greater than 1 chracter(s)';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text(
                    'Id',
                  ),
                ),
                keyboardType: TextInputType.number,
                initialValue: _enteredLatitude.toString(),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Id must not be empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  Id = int.parse(value!);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        label: Text(
                          'Latitudes',
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredLatitude.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return 'Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _enteredLatitude = double.parse(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        label: Text('Longitudes'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredLongitude.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return 'Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _enteredLongitude = double.parse(value!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add a Location'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
