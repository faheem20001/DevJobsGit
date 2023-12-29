import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/pages/admin/AddJobPage.dart';
import 'package:devjobs/pages/admin/AddUserPage.dart';
import 'package:devjobs/pages/admin/CreateJobPage.dart';
import 'package:devjobs/pages/admin/JobListPage.dart';
import 'package:devjobs/pages/admin/UserListPage.dart';
import 'package:devjobs/pages/admin/ViewContractPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/profile/ProfilePage.dart';
import '../../models/freelancer/user_model.dart';

class AdminHome extends StatefulWidget {


  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return AddUserPage();
                  }));
                },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                      child: Center(child: Text("Add User"),)
                      ,height: 160,width: 150,decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(18)
                      ),),
                    ),
                  ),
                  GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)
                    {
                      return CreateJobPage();
                    }
                    ));
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(child: Text("Add Contract"),)
                        ,height: 160,width: 150,decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(18)
                      ),),
                    ),
                  ),
                  GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)
                    {
                      return AddJobPage();
                    }));
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(child: Text("Add Jobs"),)
                        ,height: 160,width: 150,decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(18)
                      ),),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return UserListPage();
                  }));
                },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(child: Text("View Users"),)
                        ,height: 160,width: 150,decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(18)
                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return ViewContractPage();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(child: Text("View Contracts"),)
                        ,height: 160,width: 150,decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(18)
                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)
                      {
                        return JobListPage();
                      }
                      )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(child: Text("View Jobs"),)
                        ,height: 160,width: 150,decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(18)
                      ),),
                    ),
                  ),

                ],
              ),
            ),
            


          ],
        ),
          height: 580,
          width: 400,

          decoration: BoxDecoration(
              color: Colors.black12,
            border: Border.all(width: 3),
            borderRadius: BorderRadius.circular(22)
          ),
        ),
      ),

      appBar: AppBar(
      leadingWidth: 90,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
            {
              return ProfilePage(user: user!,uid: user.uid!,);
            }));
          },
          child: Icon(
            Icons.admin_panel_settings_rounded,
            size: 30,
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
        toolbarHeight: 120,
        title: Text('Admin Controls'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
