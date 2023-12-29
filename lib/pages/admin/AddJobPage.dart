import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text("N E W  J O B"),
      ),
      body: Stack(
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

                      decoration: InputDecoration(
                          hintText: "Job Title",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.lightBlueAccent),
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
                      decoration: InputDecoration(
                          hintText: "Company Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.lightBlueAccent),
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

                      minLines: 6,
                      maxLines: 11,
                      decoration: InputDecoration(
                          hintText: "Job Description",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.lightBlueAccent),
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
                              "Fixed Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            SizedBox(
                                height: 40,
                                width: 80,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(30))),
                                ))
                          ],
                        ),
                        width: 145,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.lightBlueAccent),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2025));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Duration",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Text(
                                dateStr,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          width: 145,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.lightBlueAccent),
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
              child: Container(
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightBlueAccent),
                child: Center(
                  child: Text(
                    "P O S T",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

