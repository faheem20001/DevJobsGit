import 'dart:math';

import 'package:devjobs/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../common/splash/SplashPage.dart';

class NotificationService
{
 //create instance
  final _firebaseMessaging=FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  Future initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fCMToken=await _firebaseMessaging.getToken();
    print("TOKEN:$fCMToken");
    initPushNotifications();

firebaseInit();
  }
  void handleMessage(RemoteMessage? message){
    if(message==null)return;

    navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (build)
        {
          return SplashPage();
        }
        )
    );

  }
  void initLocalNotifications(BuildContext context,RemoteMessage message)
  async{
    var androidinit=const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initsetting=InitializationSettings(
        android: androidinit
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initsetting,
      onDidReceiveNotificationResponse: (payload){
        handleMessage(message);
      }
    );

  }
  void firebaseInit()
  {
    FirebaseMessaging.onMessage.listen((message)
    {
      print(message.notification!.title);
      print(message.notification!.body);
      shownotification(message);


    }
    );
  }

  Future<void> shownotification(RemoteMessage message) async{
    AndroidNotificationChannel channel=AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'High Importance',
    importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        channel.id.toString(),
    channel.name.toString(),
    channelDescription: "CHANNEL DESC",
    importance:Importance.high,
    ticker: 'ticker',
      icon: '@mipmap/ic_launcher',);
    NotificationDetails notificationDetails=NotificationDetails(
      android: androidNotificationDetails
    );
    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationsPlugin.
      show(0, message.notification!.title.toString(),
          message.notification!.body.toString() ,
          notificationDetails

      );
    }

      );

  }
  Future initPushNotifications()async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

  }
  void shownotificationForNewData() async {

      AndroidNotificationChannel channel = AndroidNotificationChannel(
        'new_data_channel_id',
        'New Data Channel',
        importance: Importance.high,
      );

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: "Channel for new data",
        importance: Importance.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );

      await _flutterLocalNotificationsPlugin.show(
        0,
        'New Job Available',
        'Check out the latest jobs!',
        notificationDetails,
      );
    }

}