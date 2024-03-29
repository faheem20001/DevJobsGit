import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs/models/freelancer/user_model.dart';
import 'package:devjobs/services/freelancer/authservice.dart';

class UserService {
  CollectionReference _loginreference =
      FirebaseFirestore.instance.collection('login');

  CollectionReference _userrefernce =
      FirebaseFirestore.instance.collection('user');

  // registeruser

  Future<void> registerUser(UserModel user, String id, String? imgurl) async {

    try {
      await _userrefernce.doc(id).set(

        {
          "userImage":imgurl,
          'uid':id,


          "email":user.email,
          "password":user.password,
          "status":user.status,
          "createdAt":user.createdAt,
          "skills":user.skills,
          "id":id,
          "name":user.name??"Guest",
          "usertype":user.userType,
          "phone":user.phone,
          "cat":user.cat


        }


      );
    } on FirebaseException catch (e) {
      print(e);
    }
  }



  // fetch userdata

 Future<DocumentSnapshot?>fetchUserData(String id) async{

   try {
     DocumentSnapshot snapshot=await _userrefernce.doc(id).get();
     return snapshot;
   } on FirebaseException catch (e) {
     print(e);
   }



 }

}
