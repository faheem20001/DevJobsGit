import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/utils/widgets/job_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class delete_job {
  Future<void> deletejob(
      {required context, required uuid, required jobid}) async {
    User? user = FirebaseAuth.instance.currentUser;
    BuildContext dialogContext = context;
    final _uid = user!.uid;
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    if (_uid == uuid) {
                      await FirebaseFirestore.instance
                          .collection('jobs')
                          .doc(jobid)
                          .delete()
                          .then((value) {
                        Fluttertoast.showToast(
                          msg: 'Job has been deleted',
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.grey,
                          fontSize: 18,
                        );
                      });

                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    } else {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("ERROR"),
                          );
                        },
                      );
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("The task failed successfully"),
                        );
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    Text("Delete"),
                  ],
                ),
              )
            ],
          );
        });
  }
}
