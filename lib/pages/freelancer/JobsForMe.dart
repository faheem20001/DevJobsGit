import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/services/common/NotificationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/common/NotificationProvider.dart';
import '../../utils/widgets/job_widget.dart';

class JobsForMe extends StatefulWidget {
  const JobsForMe({super.key});

  @override
  State<JobsForMe> createState() => _JobsForMeState();
}

class _JobsForMeState extends State<JobsForMe> {
  int previousResultListLength=0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? usercat;
  NotificationService notificationService=NotificationService();

  void getData() async {
    User? user = FirebaseAuth.instance.currentUser;

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();

    if (userDoc == null) {
      return;
    } else {
      setState(() {
        usercat = userDoc.get('cat');

      });

    }

  }

  @override
  void initState() {
    super.initState();
    getData();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Color.fromRGBO(130, 168, 205, 1),
        title: Text("JOBS FOR YOU",style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25
        )
          ,),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('jobs')
            .where('jobcat', isEqualTo: usercat)  // Filter by user's category
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isNotEmpty == true) {
              notificationService.shownotificationForNewData();




              return ListView.builder(

                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return JobWidget(
                    jobId: snapshot.data!.docs[index]['jobid'],
                    jobtitle: snapshot.data!.docs[index]['Job Title'],
                    jobdesc: snapshot.data!.docs[index]['Job Description'],
                    dateDuration: snapshot.data!.docs[index]['Duration'],
                    uploadedBy: snapshot.data!.docs[index]['uploadedBy'],


                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text("There are no jobs"),
                ),
              );
            }
          }
          return Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
