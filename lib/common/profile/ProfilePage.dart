import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/pages/freelancer/Home.dart';
import 'package:devjobs/services/common/logoutservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  User? user = FirebaseAuth.instance.currentUser;
  final String? uid;
  ProfilePage({required this.user, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? email;
  String? ImageUrl;
  String? joinedAt;
  String? userType;
  bool isLoading = true;
  bool isSameUser = false;
  List<String> skills = [];
  String skillText = '';
  Timestamp? dateCreated;
  DateTime? createdAt;
  String? pickdate;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }

  void getData() async {
    try {
      isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDoc == null) {
        CircularProgressIndicator();
      } else {
        final _uid = widget.uid;




        setState(() {
          dateCreated=userDoc.get('createdAt');

          createdAt=dateCreated!.toDate();
          pickdate='${createdAt!.day}-${createdAt!.month}-${createdAt!.year}';
          skills = List.from(userDoc['skills']);
          ImageUrl = userDoc.get('userImage');
          userType = userDoc.get('usertype');
          skills = userDoc.get('skills');
          
          setState(() {
            isSameUser = _uid == widget.uid;
          });
        });
      }
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Divider(
                      height: 5,
                      thickness: 3,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    height: 20,
                    child: Text(
                      "A C C O U N T   I N F O R M A T I O N",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 3,
                    color: Colors.blue,
                  ),
                  SingleChildScrollView(
                    child: Padding(
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
                  ),
                  Divider(
                    height: 1,
                    thickness: 3,
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'N A M E : ${widget.user!.email}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      'A C C O U N T - T Y P E : ${userType}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  userType == 'Freelancer'
                      ? Column(
                        children: [
                          Divider(
                            height: 1,
                            thickness: 3,
                            color: Colors.blue,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'SKILLS : ${skills.join(', ')}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      )
                      : Container(),
                  Divider(
                    height: 1,
                    thickness: 3,
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'CREATED ON : ${pickdate}',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 3,
                    color: Colors.blue,
                  ),


                ],
              ),
      ),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(130, 168, 205,1),
        actions: [
          InkWell(
            onTap: () {
              logout out = logout();
              out.log_out(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Icon(
                Icons.logout_outlined,
                size: 35,
              ),
            ),
          ),
        ],
        leadingWidth: 90,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 35,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 100,
        title: Text('P R O F I L E'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}