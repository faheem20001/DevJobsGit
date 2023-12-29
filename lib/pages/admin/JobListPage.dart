import 'package:flutter/material.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context,BuildContext)
      {
        return Stack(
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: 500,
                  decoration: BoxDecoration(
                      color: Colors.grey,

                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            Positioned(
                left: 30,top: 30,
                child: Row(
                  children: [Icon(Icons.location_pin),Text(("India"))],
                )
            ),
            Positioned(
                left: 30,
                top: 65
                ,child: Text("TITLE OF THE JOB",style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20
            ),)
            ),
            Positioned(left: 40,top: 90,child: Text("Description.......................................................\n"
                "..........................................................................\n"
                "..........................................................................\n"
                "..........................................................................\n"
                "..........................................................................")),
            Positioned(top: 180,left: 25,child: Container(
              child: Column(mainAxisAlignment:MainAxisAlignment.center,
                children: [Text("VIEW",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                ),
                  Text("DETAILS",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                ],
              ),
              width: 145,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.lightBlueAccent
              ),
            )),
            Positioned(top: 180,right: 25,child: Container(
              child: Column(mainAxisAlignment:MainAxisAlignment.center,
                children: [Text("DELETE",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22),
                ),

                ],
              ),
              width: 145,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.redAccent
              ),
            )),
          ],
        );
      }
      ),
      appBar: AppBar(
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.admin_panel_settings_rounded,
            size: 30,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 120,
        title: Text('Job List'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
