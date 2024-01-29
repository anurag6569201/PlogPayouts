import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solution_challenge_app/auth.dart';
import 'package:solution_challenge_app/authenticators/Home_authenticator.dart';
import 'package:solution_challenge_app/previews/preview_home.dart';
import 'package:solution_challenge_app/splash_screen.dart';
import 'package:solution_challenge_app/tabs_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 91, 236, 144),
  ),
  appBarTheme: AppBarTheme(color: Color.fromARGB(255, 127, 242, 186)),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

bool isCompanyEmail(String email) {
  // Replace "company.com" with your company's email domain
  return email.endsWith("plogpayouts.com");
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: Builder(
          builder: (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              if (snapshot.hasData) {
                final userUid = FirebaseAuth.instance.currentUser!.uid;
                var userEmail = FirebaseAuth.instance.currentUser!.email;
                final snackbar = SnackBar(
                  content: Text('Success! Please restart the app'),
                );
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  // ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  // });
                });
                if (isCompanyEmail(userEmail!)) {
                  return homeAuthenticator(userUid);
                } else {
                  return TabsScreen(userUid);
                }
              }
              // else {
              //   return TabsScreen(username);

              // }
              // else {
              return previewScreen();
              //   return previewScreen();
              // }
            },
          ),
        ),
      ),
    );
  }
}
