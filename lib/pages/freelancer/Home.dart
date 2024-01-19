import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/profile/ProfilePage.dart';
import '../../utils/widgets/job_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  var loadjob;
  String? email;
  String? imageUrl;
  TabController? _tabController;
  TextEditingController _searchController=TextEditingController();
  List _allJobs=[];
  List _resultList=[];
  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
    getAllJobs();

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
  void getData()async{
    final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      email=userDoc.get('email');
      imageUrl=userDoc.get('userImage');
      loadjob=getAllJobs;
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
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(130, 168, 205,1),
        actions: [

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
      body: CustomScrollView(
        slivers: [

          SliverToBoxAdapter(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hey! ${email}",style: TextStyle(
                          fontSize: 23,fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      width: 380,
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


                Column(
                  children: [
                    ListView.builder(
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
                    )

                    // Container(
                    //   height: 1500,
                    //   width: 400,
                    //   child:
                    //   StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    //       stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
                    //       builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    //         if (snapshot.connectionState == ConnectionState.waiting) {
                    //           return Center(
                    //             child: CircularProgressIndicator(),
                    //           );
                    //         } else if (snapshot.connectionState == ConnectionState.active) {
                    //           if (snapshot.data?.docs.isNotEmpty == true) {
                    //             return ListView.builder(
                    //             shrinkWrap: true,
                    //               scrollDirection: Axis.vertical,
                    //               physics: NeverScrollableScrollPhysics(),
                    //
                    //               itemCount: snapshot.data!.docs.length,
                    //               itemBuilder: (BuildContext context, int index) {
                    //                 return JobWidget(
                    //                   jobId: snapshot.data!.docs[index]['jobid'],
                    //                   jobtitle: snapshot.data!.docs[index]['Job Title'],
                    //                   jobdesc: snapshot.data!.docs[index]['Job Description'],
                    //                   dateDuration: snapshot.data!.docs[index]['Duration'],
                    //                   uploadedBy: snapshot.data!.docs[index]['uploadedBy'],
                    //
                    //
                    //                 );
                    //               },
                    //             );
                    //           } else {
                    //             return Center(
                    //               child: Text("There are no jobs"),
                    //             );
                    //           }
                    //         }
                    //         return Center(
                    //           child: Text(
                    //             "Something went wrong",
                    //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //
                    //
                    //
                    //   ),

                  ],
                )



              ],
            ),

          ),
        ],
      ),
    );
  }
}
