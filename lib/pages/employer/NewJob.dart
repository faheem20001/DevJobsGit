import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/employer/uploadJobService.dart';

class NewJobPage extends StatefulWidget {
  const NewJobPage({super.key});

  @override
  State<NewJobPage> createState() => _NewJobPageState();
}

final formKey = GlobalKey<FormState>();
final TextEditingController dateController=TextEditingController(text: "Select Date");
final TextEditingController priceController=TextEditingController(text: "");
final TextEditingController jobtitleController=TextEditingController();
final TextEditingController companynameController=TextEditingController();
final TextEditingController jobdescController=TextEditingController();
final TextEditingController pdateController=TextEditingController();
var isValid=false;
String? imageUrl;

class _NewJobPageState extends State<NewJobPage> {
final posted=DateTime.now();
  DateTime? picked;
  Future<void> _pickedDate()async{
  picked=await showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100)
  );
  if(picked!=null)
    {
      setState(() {
        dateController.text='${picked!.year}-${picked!.month}-${picked!.day}';
        pdateController.text='${posted!.year}-${posted!.month}-${posted!.day}';

      });
    }
  }
void getData()async{


  final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

  setState(() {
    imageUrl=userDoc.get('userImage');
    //jobid=jobDoc.get('uploadedBy');


  });

}

@override
void initState() {
  super.initState();
  getData();
}
  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(elevation: 0,
        backgroundColor: Color.fromRGBO(130, 168, 205,1),
        toolbarHeight: 80,
        centerTitle: true,
        title: Text("N E W  J O B",style: TextStyle(
        color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25
        )
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 700,
                  width: 500,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CREATE NEW JOB",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                    ),
                    Text(
                      "Enter job details",
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 130,
                left: 30,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: jobtitleController,
                          decoration: InputDecoration(
                              hintText: "Job Title",
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromRGBO(130, 168, 205,1),),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 10, color: Colors.black),
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: companynameController,
                          decoration: InputDecoration(
                              hintText: "Company Name",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromRGBO(130, 168, 205,1),),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: jobdescController,

                          minLines: 6,
                          maxLines: 11,
                          decoration: InputDecoration(
                              hintText: "Job Description",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromRGBO(130, 168, 205,1),),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Payment Range",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16,color: Colors.white),
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: TextFormField(

                                    keyboardType: TextInputType.numberWithOptions(),
                                      controller: priceController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              )),
                                    ))
                              ],
                            ),
                            width: 145,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Color.fromRGBO(130, 168, 205,1),),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _pickedDate();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Duration",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                  SizedBox(
                                      height: 40,
                                      width: 120,
                                      child: TextFormField(
                                        enabled: false,

                                        controller: dateController,
                                        decoration: InputDecoration(

                                         border: OutlineInputBorder()
                                        ),
                                      ))
                                ],
                              ),
                              width: 145,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Color.fromRGBO(130, 168, 205,1),),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 50,
                  left: 40,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        isValid=formKey.currentState!.validate();
                        uploadJob upljob=uploadJob();
                        upljob.uploadJ(context: context,
                            imageUrl: imageUrl,
                            uid: user!.uid,
                            valid: isValid,
                            jobtitle:jobtitleController.text,
                            jobdesc:jobdescController.text,
                            duration:dateController.text,
                            deaddate:dateController.text,
                            postdate:pdateController.text,
                          pricerange:priceController.text
                        );
                      });

                    },
                    child: Container(
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(130, 168, 205,1),),
                      child: Center(
                        child: Text(
                          "P O S T",
                            style: TextStyle(
                        color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
