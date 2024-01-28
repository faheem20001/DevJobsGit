import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/common/profile/ProfilePage.dart';
import 'package:devjobs/models/freelancer/user_model.dart';
import 'package:devjobs/pages/employer/MyJobPage.dart';
import 'package:devjobs/pages/employer/NewJob.dart';
import 'package:devjobs/services/employer/uploadJobService.dart';
import 'package:devjobs/utils/widgets/job_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController=TextEditingController();
  List _allJobs=[];
  List _resultList=[];
  User? user=FirebaseAuth.instance.currentUser;
  String? imageUrl;
  String? jobid;
  var loadjob;

  @override
  void initState() {

    super.initState();
    getData();
    getAllJobs();

    _searchController.addListener(_onsearchChanged);

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


  void getData()async{


    final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      imageUrl=userDoc.get('userImage');
      loadjob=getAllJobs;
      //jobid=jobDoc.get('uploadedBy');


    });

  }
  getAllJobs()async{
    final uid=await FirebaseAuth.instance.currentUser;
    var data=await FirebaseFirestore.instance.collection('jobs').get();
    setState(() {
      _allJobs=data.docs;
    });
    searchresultlist();
    return data.docs;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(130, 168, 205,1),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NewJobPage();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                height: 100,
                width: 100,
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      right: 20,
                      child: Icon(
                        Icons.add,
                        size: 60,
                      ),
                    )
                  ],
                ),
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
                top: 40,
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
                        )),
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
          "DashBoard",
          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body:RefreshIndicator(
        onRefresh: () {
    return Future.delayed(Duration(seconds: 1),
    (){
    setState(() {
    getAllJobs();
    });

    }

    );



    },
      child:CustomScrollView(

        slivers: [
          SliverAppBar(
        floating: false,
            pinned: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(130, 168, 205,1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
              ),

              height: 80,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return MyJobPage();
                  }));
                },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(15)
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("MY JOBS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),

                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return NewJobPage();
                      }
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          color: Colors.black38,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("CREATE NEW JOB",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),


                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            backgroundColor: Colors.transparent,
            toolbarHeight: 80,

        centerTitle: false,

                automaticallyImplyLeading: false,
            expandedHeight: 10,


          ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      controller: _searchController,
                      validator: (value) {

                      },
                      decoration: InputDecoration(
                          hintText: 'Search here',
                          prefixIcon: Icon(Icons.search_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(130, 168, 205,1), width: 3),
                              borderRadius: BorderRadius.circular(40)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ListView.builder(
                physics: ScrollPhysics(),
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
              // child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              //   stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
              //   builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (snapshot.connectionState == ConnectionState.active) {
              //       if (snapshot.data?.docs.isNotEmpty == true) {
              //         return ListView.builder(
              //           physics: ScrollPhysics(),
              //         shrinkWrap: true,
              //           itemCount: snapshot.data!.docs.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             return JobWidget(
              //               jobId: snapshot.data!.docs[index]['jobid'],
              //               jobtitle: snapshot.data!.docs[index]['Job Title'],
              //               jobdesc: snapshot.data!.docs[index]['Job Description'],
              //               dateDuration: snapshot.data!.docs[index]['Duration'],
              //               uploadedBy: snapshot.data!.docs[index]['uploadedBy'],
              //
              //
              //             );
              //           },
              //         );
              //       } else {
              //         return Padding(
              //           padding: const EdgeInsets.all(20.0),
              //           child: Center(
              //             child: Text("There are no jobs"),
              //           ),
              //         );
              //       }
              //     }
              //     return Center(
              //       child: Text(
              //         "Something went wrong",
              //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              //       ),
              //     );
              //   },
              // ),
            ),



        ],


      ),
    ));
  }
}
