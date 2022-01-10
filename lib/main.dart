import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/models.dart';
import 'package:hudur/Screens/Authentication/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Components/api.dart';
import 'Screens/Home/home.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
  playSound: true,
  // sound: RawResourceAndroidNotificationSound('notification'),
  enableLights: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> firebaseMessgaingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessgaingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var listofuser = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                // sound:
                //     const RawResourceAndroidNotificationSound('notification'),
                // other properties...
                importance: channel.importance,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hudur',
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Image.asset("assets/Images/loading.gif"),
              );
            }

            SharedPreferences pref = snapshot.requireData;

            var usersString = pref.getString("user");

            var converted = usersString == null ? "" : jsonDecode(usersString);
            var converted1 = usersString == null
                ? ""
                : json.decode(json.encode(converted)) as Map<String, dynamic>;
            var users =
                usersString == null ? "" : UserModel().fromJson(converted1);

            var loggein = pref.getBool("loggedin");

            return loggein == true
                ? FutureBuilder(
                  future: AllApi().getUser(users.email),
                  builder: (context, snapshot1) {

                    if (!snapshot1.hasData) {
                      return Center(
                        child: Image.asset("assets/Images/loading.gif"),
                      );
                    }
                    var user1 = snapshot1.requireData;

                    return Home(userModel: user1);
                  }
                )
                : const Authentication();
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
