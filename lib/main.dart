import 'package:devjobs/pages/freelancer/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/login/LoginPage.dart';
import 'common/splash/SplashPage.dart';
import 'firebase_options.dart'; // Import your Firebase options here
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pages/employer/Navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}







// Your LoginPage, HomePage, NavigationPage, and other code...
