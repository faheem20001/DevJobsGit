import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class wtsapSend{




 Future<void>openwtsap
     ({required phoneNumber})
 async{
   var url='https://wa.me/$phoneNumber?text=Hello';
   launchUrlString(url);

 }
}
