import 'dart:io';

import 'package:devjobs/models/freelancer/user_model.dart';
import 'package:devjobs/services/freelancer/authservice.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}
File? ProfileImage;

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  TextEditingController _skillController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _obscure=true;
  List<String> usertypes=<String>[
    "Freelancer",
    "Employer",

  ];
  List<String> developerCategories = <String>[
    "Front-end Developer",
    "Back-end Developer",
    "Full Stack Developer",
    "Mobile App Developer",
    "Web Developer",
    "UI/UX Designer",
    "Game Developer",
    "Software Engineer",
    "DevOps Engineer",
    "Database Administrator",
    "Cloud Developer",
    "Machine Learning Engineer",
    "Blockchain Developer",
    "Embedded Systems Developer",
    "AR/VR Developer",
    "Data Scientist",
    "Quality Assurance Engineer",
    "Cybersecurity Analyst",
    "Systems Analyst",
    "Others"

  ];

  String? selectedValue;
  String? selectedCatValue;
  final _regKey = GlobalKey<FormState>();

  void _Image_dialogue()
  {
    showDialog(context: context, builder:(context)
    {
      return AlertDialog(
        title: Center(child: Text("Choose an option")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    _getfromCamera();

                  },
                  child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(8),
                      child: Icon(Icons.camera),),
                      Text("Camera"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    _getfromGallery();

                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(8),
                        child: Icon(Icons.image),),
                      Text("Image"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    );
  }

  void _getfromCamera()
  async{
    XFile? image=await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(image!.path);
    Navigator.pop(context);

  }

  void _getfromGallery()
  async{
    XFile? image=await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(image!.path);
    Navigator.pop(context);

  }

  void _cropImage(filePath)
  async{
    CroppedFile? croppedImage =await ImageCropper().cropImage(
        sourcePath: filePath,
    maxHeight: 1080,
    maxWidth: 1080);
    if(croppedImage!=null)
      {
        setState(() {
          ProfileImage=File(croppedImage.path);
        });
      }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _regKey,
        child: GestureDetector(
          onTap: (){
            _Image_dialogue();
          },
          child: Stack(
            children: [Positioned(
                child: Container(
                  width: 500,
                  height: 1000,
                  child: Stack(children: [
                    Positioned(
                        left: 160,
                        top: 100,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),

                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              child: ProfileImage==null ? const Icon(
                                Icons.add_a_photo
                              ):Image.file(ProfileImage!,fit: BoxFit.fill,),
                            ),
                          )
                        )
                    ),
                    Positioned(
                      left: 20,
                      top: 250,
                      child: Container(
                        width: 380,
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if(value!.isEmpty || !value.contains('@'))
                            {
                              return "Invalid Email";
                            }
                            else
                            {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.alternate_email_outlined),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
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
                            obscureText: _obscure,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value)
                          {
                            if(value!.isEmpty||value.length<7)
                              {
                                return 'Please enter valid password';
                              }
                            else
                              {
                                return null;
                              }
                          },
                          controller: _passwordController,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _obscure=!_obscure;
                                    });
                                  }
                                  ,child: Icon(Icons.remove_red_eye,)),
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.key),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
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
                          obscureText: _obscure,
                          controller: _cpasswordController,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _obscure=!_obscure;
                                    });
                                  }
                                  ,child: Icon(Icons.remove_red_eye,)),

                              hintText: 'Re-Password',
                              prefixIcon: Icon(Icons.key),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 460,
                      child: Container(
                        width: 380,
                        height: 200,
                        child: TextFormField(
                          controller: _skillController,
                          minLines: 1,
                          maxLines: 11,
                          decoration: InputDecoration(
                              hintText: 'Skills',
                              prefixIcon: Icon(Icons.local_activity_outlined),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 530,
                      child: Container(
                        width: 380,
                        child: TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            // Define a regular expression for a valid phone number with country code
                            RegExp phoneRegex = RegExp(r'^\+\d{1,3}\s?\d{1,14}$');

                            if (value!.isEmpty || !phoneRegex.hasMatch(value)) {
                              return "Invalid Phone Number";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Phone number with country code',
                              prefixIcon: Icon(Icons.phone),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF81D4FA), width: 3),
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                    ),
                    Positioned(
                    top: 630, left: 145, child:
                    Row(
                      children: [
                        Text("Role:  ",style: TextStyle(
                          fontSize: 18
                        ),),
                        DropdownButton(
                          value:selectedValue,
                          items: usertypes.map<DropdownMenuItem<String>>(
                                  (String value)
                              {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value));
                              }).toList(),

                          onChanged: (String? newvalue){
                            setState(() {
                              selectedValue=newvalue;

                            });

                          },
                        ),
                      ],
                    )
                    ),
                    Positioned(
                        top: 700, left: 20, child:
                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF81D4FA), width: 3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Categories:  ",
                            style: TextStyle(fontSize: 18),
                          ),
                          DropdownButton(
                            value: selectedCatValue,
                            items: developerCategories.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newvalue) {
                              setState(() {
                                selectedCatValue = newvalue;
                              });
                            },
                          ),
                        ],
                      ),
                    )


                    ),
                    Positioned(
                      top: 770,
                      left: 20,
                      child: InkWell(
                        onTap: () {
                          if(_regKey.currentState!.validate())
                          {

                            var skills = _skillController.text.split(",");

                            UserModel user = UserModel(
                              email: _emailController.text,
                              password: _passwordController.text,
                              createdAt: DateTime.now(),
                              status: 1,
                              skills: skills,
                              userType: selectedValue,
                              phone: _phoneController.text,
                              cat:selectedCatValue
                            );

                            AuthService _authService = AuthService();

                            _authService.createUser(user,).then((value) {



                              Navigator.pop(context);

                            });

                          }




                        },
                        child: Container(
                          child: Center(
                              child: Text("Register",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700))),
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Color(0xFF81D4FA), width: 5),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 700,
                    //   left: 20,
                    //   child: Container(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Image.asset(
                    //           'assets/icon/g.png',
                    //           scale: 50,
                    //         ),
                    //         Text("Sign in with google",
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.w700)),
                    //       ],
                    //     ),
                    //     width: 380,
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //         border:
                    //             Border.all(color: Color(0xFF81D4FA), width: 5),
                    //         color: Colors.transparent,
                    //         borderRadius: BorderRadius.circular(40)),
                    //   ),
                    // )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
