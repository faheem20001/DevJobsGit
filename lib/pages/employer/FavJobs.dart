import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/utils/widgets/job_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavJobs extends StatefulWidget {
  const FavJobs({super.key});

  @override
  State<FavJobs> createState() => _FavJobsState();
}

class _FavJobsState extends State<FavJobs> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:                       StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users-fav-jobs').doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('jobs').where('userid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isNotEmpty == true) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                

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
              return Center(
                child: Text("There are no jobs"),
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
