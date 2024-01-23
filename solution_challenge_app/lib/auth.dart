import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solution_challenge_app/garbage_collector_auth.dart';
import 'package:solution_challenge_app/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<Auth> {
  var _isLogin = true;
  var _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredUserName = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;

  void _saveForm() async {
    setState(() {
      _isAuthenticating = true;
    });
    final _isValid = _formKey.currentState!.validate();

    if (!_isValid || !_isLogin && _selectedImage == null) {
      return;
    } else {
      _formKey.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
      if (_isLogin) {
        try {
          final _userCredentials = await _firebase.signInWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);
        } on FirebaseAuthException catch (error) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.message ?? 'Authentication failed!',
              ),
            ),
          );
        }
      } else {
        try {
          final _userCredentials =
              await _firebase.createUserWithEmailAndPassword(
                  email: _enteredEmail, password: _enteredPassword);
          print(_userCredentials);
          final _storeImage = FirebaseStorage.instance
              .ref()
              .child('user-images')
              .child('${_userCredentials.user!.uid}.jpg');

          await _storeImage.putFile(_selectedImage!);

          final _imageUrl = await _storeImage.getDownloadURL();

          FirebaseFirestore.instance
              .collection('users')
              .doc(_userCredentials.user!.uid)
              .set({
            'username': _enteredUserName,
            'email': _enteredEmail,
            'image_url': _imageUrl
          });
        } on FirebaseAuthException catch (error) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Authentication failed!'),
            ),
          );
        }
      }
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChanged = false;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // padding: const EdgeInsets.only(
                  //   top: 30,
                  //   bottom: 20,
                  //   left: 20,
                  //   right: 20,
                  // ),
                  width: double.infinity,
                  height: 290,
                  child: Image.asset('assets/images/logo_1.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImage((pickedImage) {
                              _selectedImage = pickedImage;
                            }),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Your Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                labelText: 'Your Username',
                              ),
                              // keyboardType: TextInputType.emailAddress,
                              // autocorrect: false,
                              // textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.trim().length <= 4) {
                                  return 'Please enter a valid user name';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _enteredUserName = newValue!;
                              },
                            ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Your Password',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length <= 6) {
                                return 'Please enter a valid password atle  ast 6 characters';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                            // keyboardType: TextInputType.emailAddress,
                            // autocorrect: false,
                            // textCapitalization: TextCapitalization.none,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              onPressed: _saveForm,
                              child: Text(_isLogin ? 'Login' : 'Sign Up'),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create one!'
                                  : 'I have an account already'),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Authenticator?',
                                style: TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 5, 134, 10),
                                ),
                              ),
                              Switch(
                                value: isChanged,
                                onChanged: (value) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => collectorAuth(),
                                  ));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
