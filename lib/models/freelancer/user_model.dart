
import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel{


  String?id;
  String?name;
  String?password;
  String?email;
  int?status;
  String? userType;
  String? phone;
  var createdAt;
  List?skills;



  UserModel({

    this.email,this.id,this.name,this.createdAt,this.skills,this.status,this.password,this.userType,this.phone
});




  factory UserModel.fromJson(Map<String,dynamic> data){


    return UserModel(

      id: data['id'],
      name: data['name'],
      email: data['email'],
      skills: data['skills'],
      createdAt: data['createdAt'],
      status: data['status'],
      userType: data['userType'],
        phone: data['phone']



    );
  }


  static UserModel fromSnapShot(DocumentSnapshot snapshot){

    final data=snapshot.data() as Map<String,dynamic>;

    data['uid']=snapshot.id;

    return UserModel.fromJson(data);
  }

  toMap(UserModel user){

    return {

      "id":user.id,
      "name":user.name,
      "email":user.email,
      "createdAt":user.createdAt,
      "status":user.status,
      "skills":user.skills,
      'password':user.password,
      'userType':user.userType,
      'phone':user.phone
    };
  }


}