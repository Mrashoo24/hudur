import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/models.dart';
import 'package:hudur/Screens/Authentication/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Home/home.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  var listofuser = [];
  // This widget is the root of your application.
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
                ? Home(userModel: users)
                : const Authentication();
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
