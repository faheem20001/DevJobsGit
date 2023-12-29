import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/common/login/LoginPage.dart';
import 'package:devjobs/models/freelancer/user_model.dart';
import 'package:devjobs/pages/employer/Navigation.dart';
import 'package:devjobs/pages/freelancer/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RouteService {
  Future<void> route({required BuildContext context, required UserModel userModel}) async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (context != null) {
      if (firebaseUser != null) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .doc(firebaseUser.uid)
            .get();

        if (documentSnapshot.exists) {
          String userType = documentSnapshot.get('usertype') ?? ""; // Provide a default value if 'usertype' is null

          if (userType == "Freelancer") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationPage(),
              ),
            );
          }
        } else {
          print('Document does not exist in the database');
        }
      } else {
        print('User is not logged in');
        Future.delayed(Duration(seconds: 3),
            (){

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            });

        // Handle user not logged in, navigate to login page or take necessary action
      }
    } else {
      print('Context is null');
      // Handle the null context scenario here
    }
  }
}
