import 'package:flutter/material.dart';
import 'package:hudur/Screens/Authentication/authentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hudur',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Authentication(),
      debugShowCheckedModeBanner: false,
    );
  }
}
