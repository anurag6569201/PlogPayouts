import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solution_challenge_app/auth.dart';
import 'package:solution_challenge_app/splash_screen.dart';
import 'package:solution_challenge_app/tabs_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var _userName = 'Welcome';

  void _getUserName(String uid) async {
    var _userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    _userName = _userData.data()!['username'];
    print(_userName);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }

          if (snapshot.hasData) {
            final userUid = FirebaseAuth.instance.currentUser!.uid;

            // var username = snapshot.data!.displayName;
            // print(snapshot);
            // final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
            // if (username == null) {
            // _getUserName(userUid);
            //   return TabsScreen(username);
            return TabsScreen(userUid);
          }
          // else {
          //   return TabsScreen(username);

          // }
          else {
            return Auth();
          }
        },
      ),
    );
  }
}
