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
  String? email;
  String? imageUrl;
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
    getData();
  }
  void getData()async{
    final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      email=userDoc.get('email');
      imageUrl=userDoc.get('userImage');
    });
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

          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(

              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Hey! ${email}",style: TextStyle(
                            fontSize: 23,fontWeight: FontWeight.w600
                        ),),
                      ],
                    ),
                
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(




                        child: Column(
                          children: [

                            Container(
                              height: 1500,
                              width: 400,
                              child:
                              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
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
                                          physics: NeverScrollableScrollPhysics(),

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



                              ),

                          ],
                        ),

                      ),
                    )



                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
