


import 'package:devjobs/pages/freelancer/HomePage.dart';
import 'package:devjobs/services/common/NotificationProvider.dart';
import 'package:devjobs/services/common/NotificationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'common/login/LoginPage.dart';
import 'common/splash/SplashPage.dart';
import 'firebase_options.dart'; // Import your Firebase options here
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pages/employer/Navigation.dart';

final navigatorKey=GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initNotifications();
  FirebaseMessaging.onBackgroundMessage(_FirebaseMessagingBackgroundHandler);



  runApp(

      ChangeNotifierProvider(

      create: (context)=>NotificationProvider(),
      child: MyApp()));
}
@pragma('vm:entry-point')
Future<void> _FirebaseMessagingBackgroundHandler(RemoteMessage message)async{

  await Firebase.initializeApp();

  print(message.notification!.title.toString());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return

      MaterialApp(

      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}







// Your LoginPage, HomePage, NavigationPage, and other code...
