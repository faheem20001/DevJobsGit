





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/pages/employer/NewJob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../freelancer/authservice.dart';

class uploadJob{




  Future<dynamic> uploadJ({
    required context
})
  async{
    final jobId=const Uuid().v4();
    User? user=FirebaseAuth.instance.currentUser;
    final _uid=user!.uid;
    final isValid=formKey.currentState!.validate();
    if(isValid)
      {
        if(dateController.text=="Duration")
          {
            return showDialog(context: context, builder: (ctx)
            {

            return AlertDialog(
                title: Text("ERROR"),

              );
            }

            );

          }
        try
        {
          await FirebaseFirestore.instance.collection('jobs').doc(jobId).set({
            'jobid':jobId,
            'uploadedBy':_uid,

            'email':user.email,
            'Job Title':jobtitleController.text,
            'Job Description':jobdescController.text,
            'Duration':dateController.text,
            'userImage':ImageUrl.toString(),
            'applicants':0,
            'location':'',
            'deadDate':dateController.text,
            'postDate':pdateController.text,
            'name':user.displayName,
            'availability':true,
            'createdAt':DateTime.now().toString(),









          });
          await Fluttertoast.showToast(
              msg: "The job has been uploaded",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.green,
          fontSize: 18);
          jobtitleController.clear();
          jobdescController.clear();

        }
        catch(e)
    {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("ERROR"),

        );
      });
    }finally{
          

        }

      }

  }


}