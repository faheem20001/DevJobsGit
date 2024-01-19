

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/utils/widgets/wtsapSend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmployerInfo extends StatefulWidget {
  final String uploadedBy;
  const EmployerInfo({super.key,required this.uploadedBy});

  @override
  State<EmployerInfo> createState() => _EmployerInfoState();
}

class _EmployerInfoState extends State<EmployerInfo> {
  bool isLoading=false;
  String? email;
  String? ImageUrl;
  String? phone;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }

  void getData() async {
    try {
      setState(() {
        isLoading=true;
      });


      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.uploadedBy)
           .get();

      if (userDoc == null) {
        CircularProgressIndicator();
      } else {
        //final _uid = FirebaseAuth.instance.currentUser!.uid;




        setState(() {


          email=userDoc.get('email');


          //skills = List.from(userDoc['skills']);
          ImageUrl = userDoc.get('userImage');
          phone=userDoc.get('phone');
          //ImageUrl = userDoc.get('phone');



        }
        );
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  wtsapSend wtsap=new wtsapSend();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:  AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(130, 168, 205, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);

            },
            icon: Icon(
              Icons.close,
              size: 25,
              color: Colors.white,
            ),
          ),
          title: Text("EMPLOYER DETAILS",style: TextStyle(
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
        body: Column(
          children: [Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(ImageUrl == null
                        ? 'https://placehold.co/600x400.png'
                        : ImageUrl!),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
            Divider(
              height: 1,
              thickness: 3,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'N A M E : ${email}',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 1,
              thickness: 3,
              color: Colors.blue,
            ),
            InkWell(
              onTap: (){
                wtsap.openwtsap(phoneNumber: phone);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       CircleAvatar(
                         radius: 35,
                         backgroundColor: Colors.lightGreen[300],
                         child: IconButton(
                           onPressed: (){

                            wtsap.openwtsap(phoneNumber: phone);
                           },

                           icon: Icon(
                             FontAwesomeIcons.whatsapp,
                             size: 40,
                           ),
                         ),
                       ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Contact via Whatsapp',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 3,
                    color: Colors.blue,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.lightGreen[300],
                          child: IconButton(
                            onPressed: (){

                              final Uri params = Uri(
                                scheme: 'mailto',
                                path: email,
                                query: "subject=Applying for Job&body=Hello, please attach Resume CV file",
                              );
                              final url=params.toString();
                              launchUrlString(url);
                            },

                            icon: Icon(
                              Icons.mail_outline_rounded,
                              size: 40,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Contact via Email',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 3,
                    color: Colors.blue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
