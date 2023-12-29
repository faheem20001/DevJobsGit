import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(

            child: Container(
              width: 500,
              height: 1000,


              child: Stack(children: [
                Positioned(
                    left: 70,
                    top: 180,
                    child: Text("REGISTER/ADD USER",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))),

                Positioned(
                  left: 20,
                  top: 250,
                  child: Container(
                    width: 380,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 320,
                  child: Container(
                    width: 380,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.key),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 390,
                  child: Container(
                    width: 380,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Re-Password',
                          prefixIcon: Icon(Icons.key),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 460,
                  child: Container(
                    width: 380,
                    height: 300,
                    child: TextFormField(

                      minLines: 5,
                      maxLines: 11,

                      decoration: InputDecoration(
                          hintText: 'Skills',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 77,left: 10),
                            child: Icon(Icons.local_activity_outlined),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ),

                Positioned(
                  top: 620,
                  left: 20,

                  child: Container(
                    child: Center(child:Text("Register",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ))),
                    width: 380,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFF81D4FA),
                            width: 5
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(40)
                    ),

                  ),),
                // Positioned(
                //   top: 700,
                //   left: 20,
                //
                //   child: Container(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset('assets/icon/g.png',scale: 50,),
                //         Text("Sign in with google",
                //             style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.w700
                //             )),
                //       ],
                //     ),
                //     width: 380,
                //     height: 60,
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //             color: Color(0xFF81D4FA),
                //             width: 5
                //         ),
                //         color: Colors.transparent,
                //         borderRadius: BorderRadius.circular(40)
                //     ),
                //
                //   ),)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

