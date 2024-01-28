import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/pages/employer/FavJobs.dart';
import 'package:devjobs/pages/employer/NewJob.dart';
import 'package:devjobs/pages/freelancer/JobsForMe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../common/profile/ProfilePage.dart';
import '../../services/common/NotificationProvider.dart';
import '../../services/common/NotificationService.dart';
import '../../utils/widgets/job_widget.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  NotificationService notificationService=NotificationService();
  int previousResultListLength=0;
  var loadjob;
  String? email;
  String? imageUrl;
  TabController? _tabController;
  TextEditingController _searchController = TextEditingController();
  List _allJobs = [];
  List _resultList = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      getAllJobs();
    });


    _searchController.addListener(_onsearchChanged);
    getData();
  }

  _onsearchChanged() {
    searchresultlist();
    print(_searchController.text);
  }

  searchJobs(String query) {
    return _allJobs.where((job) {
      final title = job['Job Title'].toString().toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();
  }

  searchresultlist() {
    var showResults = [];
    if (_searchController.text != "") {
      showResults = searchJobs(_searchController.text);
    } else {
      showResults = List.from(_allJobs);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  void getData() async {
    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      email = userDoc.get('email');
      imageUrl = userDoc.get('userImage');
      loadjob = getAllJobs;
    });
  }

  getAllJobs() async {
    final uid = await FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance.collection('jobs').get();
    setState(() {
      _allJobs = data.docs;
    });
    searchresultlist();
    return data.docs;
  }

  @override
  Widget build(BuildContext context) {
    if (_resultList.length > previousResultListLength) {
      notificationService.shownotificationForNewData();
      getAllJobs();
      previousResultListLength = _resultList.length; // Update the previous length
    }
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(130, 168, 205, 1),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return FavJobs();
                }));
              },
              icon: Icon(
                FontAwesomeIcons.heart,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return JobsForMe();
                }));
              },
              icon: Icon(
                FontAwesomeIcons.brain,
                size: 40,
              ),
            ),
          )
        ],
        leadingWidth: 100,
        leading: Container(
          width: 200,
          height: 100,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 35,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ProfilePage(uid: user!.uid,);
                    }));
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(imageUrl == null
                            ? 'https://placehold.co/600x400.png'
                            : imageUrl!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 130,
        title: Text(
          "DevJobs",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1),
                  (){
                setState(() {
                  getAllJobs();
                });

              }

          );



        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hey! ${email}",
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 380,
                        child: TextFormField(
                          controller: _searchController,
                          validator: (value) {},
                          decoration: InputDecoration(
                            hintText: 'Search here',
                            prefixIcon: Icon(Icons.search_outlined),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(130, 168, 205, 1), width: 3),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      RefreshIndicator(
                        onRefresh: () {
                         return Future.delayed(Duration(seconds: 1),
                             (){
                           setState(() {
                             getAllJobs();
                           });

                             }

                         );



                        },
                        child: ListView.builder(
                         physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _resultList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return JobWidget(
                              jobId: _resultList[index]['jobid'],
                              jobtitle: _resultList[index]['Job Title'],
                              jobdesc: _resultList[index]['Job Description'],
                              dateDuration: _resultList[index]['Duration'],
                              uploadedBy: _resultList[index]['uploadedBy'],
                            );
                          },
                        ),

                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

